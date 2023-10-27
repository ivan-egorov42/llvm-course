#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
using namespace llvm;

namespace {
struct MyPass : public FunctionPass {
  static char ID;
  MyPass() : FunctionPass(ID) {}

  bool isFuncLogger(StringRef name) { 
    return name == "_Z10insnLoggerPclm" ||
           name == "_Z4dumpv";
  }

  virtual bool runOnFunction(Function &F) {
    if (isFuncLogger(F.getName())) {
      return false;
    }

    //outs() << F.getName() << "\n";

    // for (auto &B : F) {
    //   for (auto &I : B) {
    //     // Dump Instructions
    //     outs() << "Instruction: " << (uint64_t)(&I) << "\n";
    //     I.print(outs(), true);
    //     outs() << "\n";
    //   }
    //   outs() << "\n";
    // }  

    LLVMContext &Ctx = F.getContext();
    IRBuilder<> builder(Ctx);
    Type *retType = Type::getVoidTy(Ctx);

    ArrayRef<Type *> insnLogParamTypes = {
        builder.getInt8Ty()->getPointerTo(),
        Type::getInt64Ty(Ctx),
        Type::getInt32Ty(Ctx)
        };
    FunctionType *insnLogFuncType =
        FunctionType::get(retType, insnLogParamTypes, false);
    FunctionCallee insnLogFunc = F.getParent()->getOrInsertFunction(
        "_Z10insnLoggerPclm", insnLogFuncType);

    ArrayRef<Type *> dumpParamTypes = {};
    FunctionType *dumpFuncType = FunctionType::get(retType, dumpParamTypes, false);
    FunctionCallee dumpFunc = F.getParent()->getOrInsertFunction("_Z4dumpv", dumpFuncType);

    for (auto &B : F) {
        for (auto &I : B) {

            auto *insn = &I;
            if (!insn || insn->getIterator() == B.end() || insn->getIterator() == B.begin())
                continue;

            auto *call = dyn_cast<CallInst>(&I);
            if (call && call->getCalledFunction() && isFuncLogger(call->getCalledFunction()->getName()))
                continue;

            auto *phi = dyn_cast<PHINode>(&I);
            if (phi)
                continue;

            Value *valueAddr =
                ConstantInt::get(builder.getInt64Ty(), (int64_t)(&I));

            builder.SetInsertPoint(insn);
            Value *opName = builder.CreateGlobalStringPtr(insn->getOpcodeName());
            Value *insnOpcode = ConstantInt::get(builder.getInt64Ty(), (int64_t)(I.getOpcode()));
            Value *args[] = {opName, valueAddr, insnOpcode};
            builder.CreateCall(insnLogFunc, args);

            if (auto *ret = dyn_cast<ReturnInst>(&I))
              if (F.getName() == "main")
                builder.CreateCall(dumpFunc, None);
        }
    }
    return true;
  }
};
} //namespace

char MyPass::ID = 0;

static void registerMyPass(const PassManagerBuilder &,
                                 legacy::PassManagerBase &PM) {
  PM.add(new MyPass());
}
static RegisterStandardPasses
    RegisterMyPass(PassManagerBuilder::EP_OptimizerLast,
                   registerMyPass);