; ModuleID = 'life.c'
source_filename = "life.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @drawGen(i32* %0) #0 {
  %2 = alloca i32*, align 8
  store i32* %0, i32** %2, align 8
  %3 = load i32*, i32** %2, align 8
  call void @simSetPixels(i32* %3)
  call void (...) @simFlush()
  ret void
}

declare dso_local void @simSetPixels(i32*) #1

declare dso_local void @simFlush(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @count_neighbors(i32 %0, i32 %1, i32* %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, i32* %5, align 4
  store i32 %1, i32* %6, align 4
  store i32* %2, i32** %7, align 8
  store i32 0, i32* %8, align 4
  %11 = load i32, i32* %5, align 4
  %12 = sub i32 %11, 1
  store i32 %12, i32* %9, align 4
  br label %13

13:                                               ; preds = %70, %3
  %14 = load i32, i32* %9, align 4
  %15 = load i32, i32* %5, align 4
  %16 = add i32 %15, 1
  %17 = icmp ule i32 %14, %16
  br i1 %17, label %18, label %73

18:                                               ; preds = %13
  %19 = load i32, i32* %6, align 4
  %20 = sub i32 %19, 1
  store i32 %20, i32* %10, align 4
  br label %21

21:                                               ; preds = %66, %18
  %22 = load i32, i32* %10, align 4
  %23 = load i32, i32* %6, align 4
  %24 = add i32 %23, 1
  %25 = icmp ule i32 %22, %24
  br i1 %25, label %26, label %69

26:                                               ; preds = %21
  %27 = load i32, i32* %9, align 4
  %28 = icmp ult i32 %27, 0
  br i1 %28, label %38, label %29

29:                                               ; preds = %26
  %30 = load i32, i32* %9, align 4
  %31 = icmp uge i32 %30, 600
  br i1 %31, label %38, label %32

32:                                               ; preds = %29
  %33 = load i32, i32* %10, align 4
  %34 = icmp ult i32 %33, 0
  br i1 %34, label %38, label %35

35:                                               ; preds = %32
  %36 = load i32, i32* %10, align 4
  %37 = icmp uge i32 %36, 800
  br i1 %37, label %38, label %39

38:                                               ; preds = %35, %32, %29, %26
  br label %66

39:                                               ; preds = %35
  %40 = load i32, i32* %9, align 4
  %41 = load i32, i32* %5, align 4
  %42 = icmp eq i32 %40, %41
  br i1 %42, label %43, label %48

43:                                               ; preds = %39
  %44 = load i32, i32* %10, align 4
  %45 = load i32, i32* %6, align 4
  %46 = icmp eq i32 %44, %45
  br i1 %46, label %47, label %48

47:                                               ; preds = %43
  br label %66

48:                                               ; preds = %43, %39
  %49 = load i32*, i32** %7, align 8
  %50 = load i32, i32* %9, align 4
  %51 = mul i32 %50, 800
  %52 = load i32, i32* %10, align 4
  %53 = add i32 %51, %52
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds i32, i32* %49, i64 %54
  %56 = load i32, i32* %55, align 4
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %65

58:                                               ; preds = %48
  %59 = load i32, i32* %8, align 4
  %60 = add nsw i32 %59, 1
  store i32 %60, i32* %8, align 4
  %61 = icmp sgt i32 %60, 3
  br i1 %61, label %62, label %64

62:                                               ; preds = %58
  %63 = load i32, i32* %8, align 4
  store i32 %63, i32* %4, align 4
  br label %75

64:                                               ; preds = %58
  br label %65

65:                                               ; preds = %64, %48
  br label %66

66:                                               ; preds = %65, %47, %38
  %67 = load i32, i32* %10, align 4
  %68 = add i32 %67, 1
  store i32 %68, i32* %10, align 4
  br label %21, !llvm.loop !2

69:                                               ; preds = %21
  br label %70

70:                                               ; preds = %69
  %71 = load i32, i32* %9, align 4
  %72 = add i32 %71, 1
  store i32 %72, i32* %9, align 4
  br label %13, !llvm.loop !4

73:                                               ; preds = %13
  %74 = load i32, i32* %8, align 4
  store i32 %74, i32* %4, align 4
  br label %75

75:                                               ; preds = %73, %62
  %76 = load i32, i32* %4, align 4
  ret i32 %76
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @calcCell(i32 %0, i32 %1, i32 %2, i32* %3, i32* %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32*, align 8
  %10 = alloca i32*, align 8
  store i32 %0, i32* %6, align 4
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i32* %3, i32** %9, align 8
  store i32* %4, i32** %10, align 8
  %11 = load i32*, i32** %9, align 8
  %12 = load i32, i32* %7, align 4
  %13 = mul i32 %12, 800
  %14 = load i32, i32* %8, align 4
  %15 = add i32 %13, %14
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds i32, i32* %11, i64 %16
  %18 = load i32, i32* %17, align 4
  %19 = load i32*, i32** %10, align 8
  %20 = load i32, i32* %7, align 4
  %21 = mul i32 %20, 800
  %22 = load i32, i32* %8, align 4
  %23 = add i32 %21, %22
  %24 = zext i32 %23 to i64
  %25 = getelementptr inbounds i32, i32* %19, i64 %24
  store i32 %18, i32* %25, align 4
  %26 = load i32*, i32** %9, align 8
  %27 = load i32, i32* %7, align 4
  %28 = mul i32 %27, 800
  %29 = load i32, i32* %8, align 4
  %30 = add i32 %28, %29
  %31 = zext i32 %30 to i64
  %32 = getelementptr inbounds i32, i32* %26, i64 %31
  %33 = load i32, i32* %32, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %46

35:                                               ; preds = %5
  %36 = load i32, i32* %6, align 4
  %37 = icmp slt i32 %36, 2
  br i1 %37, label %38, label %46

38:                                               ; preds = %35
  %39 = load i32*, i32** %10, align 8
  %40 = load i32, i32* %7, align 4
  %41 = mul i32 %40, 800
  %42 = load i32, i32* %8, align 4
  %43 = add i32 %41, %42
  %44 = zext i32 %43 to i64
  %45 = getelementptr inbounds i32, i32* %39, i64 %44
  store i32 0, i32* %45, align 4
  br label %46

46:                                               ; preds = %38, %35, %5
  %47 = load i32*, i32** %9, align 8
  %48 = load i32, i32* %7, align 4
  %49 = mul i32 %48, 800
  %50 = load i32, i32* %8, align 4
  %51 = add i32 %49, %50
  %52 = zext i32 %51 to i64
  %53 = getelementptr inbounds i32, i32* %47, i64 %52
  %54 = load i32, i32* %53, align 4
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %70

56:                                               ; preds = %46
  %57 = load i32, i32* %6, align 4
  %58 = icmp eq i32 %57, 2
  br i1 %58, label %62, label %59

59:                                               ; preds = %56
  %60 = load i32, i32* %6, align 4
  %61 = icmp eq i32 %60, 3
  br i1 %61, label %62, label %70

62:                                               ; preds = %59, %56
  %63 = load i32*, i32** %10, align 8
  %64 = load i32, i32* %7, align 4
  %65 = mul i32 %64, 800
  %66 = load i32, i32* %8, align 4
  %67 = add i32 %65, %66
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds i32, i32* %63, i64 %68
  store i32 1, i32* %69, align 4
  br label %70

70:                                               ; preds = %62, %59, %46
  %71 = load i32*, i32** %9, align 8
  %72 = load i32, i32* %7, align 4
  %73 = mul i32 %72, 800
  %74 = load i32, i32* %8, align 4
  %75 = add i32 %73, %74
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds i32, i32* %71, i64 %76
  %78 = load i32, i32* %77, align 4
  %79 = icmp ne i32 %78, 0
  br i1 %79, label %80, label %91

80:                                               ; preds = %70
  %81 = load i32, i32* %6, align 4
  %82 = icmp sgt i32 %81, 3
  br i1 %82, label %83, label %91

83:                                               ; preds = %80
  %84 = load i32*, i32** %10, align 8
  %85 = load i32, i32* %7, align 4
  %86 = mul i32 %85, 800
  %87 = load i32, i32* %8, align 4
  %88 = add i32 %86, %87
  %89 = zext i32 %88 to i64
  %90 = getelementptr inbounds i32, i32* %84, i64 %89
  store i32 0, i32* %90, align 4
  br label %91

91:                                               ; preds = %83, %80, %70
  %92 = load i32*, i32** %9, align 8
  %93 = load i32, i32* %7, align 4
  %94 = mul i32 %93, 800
  %95 = load i32, i32* %8, align 4
  %96 = add i32 %94, %95
  %97 = zext i32 %96 to i64
  %98 = getelementptr inbounds i32, i32* %92, i64 %97
  %99 = load i32, i32* %98, align 4
  %100 = icmp ne i32 %99, 0
  br i1 %100, label %112, label %101

101:                                              ; preds = %91
  %102 = load i32, i32* %6, align 4
  %103 = icmp eq i32 %102, 3
  br i1 %103, label %104, label %112

104:                                              ; preds = %101
  %105 = load i32*, i32** %10, align 8
  %106 = load i32, i32* %7, align 4
  %107 = mul i32 %106, 800
  %108 = load i32, i32* %8, align 4
  %109 = add i32 %107, %108
  %110 = zext i32 %109 to i64
  %111 = getelementptr inbounds i32, i32* %105, i64 %110
  store i32 1, i32* %111, align 4
  br label %112

112:                                              ; preds = %104, %101, %91
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @calcGen(i32* %0, i32* %1) #0 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32* %0, i32** %3, align 8
  store i32* %1, i32** %4, align 8
  store i32 0, i32* %5, align 4
  br label %7

7:                                                ; preds = %27, %2
  %8 = load i32, i32* %5, align 4
  %9 = icmp ult i32 %8, 600
  br i1 %9, label %10, label %30

10:                                               ; preds = %7
  store i32 0, i32* %6, align 4
  br label %11

11:                                               ; preds = %23, %10
  %12 = load i32, i32* %6, align 4
  %13 = icmp ult i32 %12, 800
  br i1 %13, label %14, label %26

14:                                               ; preds = %11
  %15 = load i32, i32* %5, align 4
  %16 = load i32, i32* %6, align 4
  %17 = load i32*, i32** %4, align 8
  %18 = call i32 @count_neighbors(i32 %15, i32 %16, i32* %17)
  %19 = load i32, i32* %5, align 4
  %20 = load i32, i32* %6, align 4
  %21 = load i32*, i32** %4, align 8
  %22 = load i32*, i32** %3, align 8
  call void @calcCell(i32 %18, i32 %19, i32 %20, i32* %21, i32* %22)
  br label %23

23:                                               ; preds = %14
  %24 = load i32, i32* %6, align 4
  %25 = add i32 %24, 1
  store i32 %25, i32* %6, align 4
  br label %11, !llvm.loop !5

26:                                               ; preds = %11
  br label %27

27:                                               ; preds = %26
  %28 = load i32, i32* %5, align 4
  %29 = add i32 %28, 1
  store i32 %29, i32* %5, align 4
  br label %7, !llvm.loop !6

30:                                               ; preds = %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca [480000 x i32], align 16
  %6 = alloca [480000 x i32], align 16
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32*, align 8
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  store i32 0, i32* %3, align 4
  store i32 0, i32* %4, align 4
  %10 = getelementptr inbounds [480000 x i32], [480000 x i32]* %5, i64 0, i64 0
  store i32* %10, i32** %7, align 8
  %11 = getelementptr inbounds [480000 x i32], [480000 x i32]* %6, i64 0, i64 0
  store i32* %11, i32** %8, align 8
  store i32 0, i32* %3, align 4
  br label %12

12:                                               ; preds = %33, %0
  %13 = load i32, i32* %3, align 4
  %14 = icmp ult i32 %13, 600
  br i1 %14, label %15, label %36

15:                                               ; preds = %12
  store i32 0, i32* %2, align 4
  br label %16

16:                                               ; preds = %29, %15
  %17 = load i32, i32* %2, align 4
  %18 = icmp ult i32 %17, 800
  br i1 %18, label %19, label %32

19:                                               ; preds = %16
  %20 = call i32 (...) @simRand()
  %21 = urem i32 %20, 2
  %22 = load i32*, i32** %8, align 8
  %23 = load i32, i32* %3, align 4
  %24 = mul i32 %23, 800
  %25 = load i32, i32* %2, align 4
  %26 = add i32 %24, %25
  %27 = zext i32 %26 to i64
  %28 = getelementptr inbounds i32, i32* %22, i64 %27
  store i32 %21, i32* %28, align 4
  br label %29

29:                                               ; preds = %19
  %30 = load i32, i32* %2, align 4
  %31 = add i32 %30, 1
  store i32 %31, i32* %2, align 4
  br label %16, !llvm.loop !7

32:                                               ; preds = %16
  br label %33

33:                                               ; preds = %32
  %34 = load i32, i32* %3, align 4
  %35 = add i32 %34, 1
  store i32 %35, i32* %3, align 4
  br label %12, !llvm.loop !8

36:                                               ; preds = %12
  call void (...) @simInit()
  %37 = load i32*, i32** %8, align 8
  call void @drawGen(i32* %37)
  store i32 0, i32* %4, align 4
  br label %38

38:                                               ; preds = %48, %36
  %39 = load i32, i32* %4, align 4
  %40 = icmp ult i32 %39, 1024
  br i1 %40, label %41, label %51

41:                                               ; preds = %38
  %42 = load i32*, i32** %7, align 8
  %43 = load i32*, i32** %8, align 8
  call void @calcGen(i32* %42, i32* %43)
  %44 = load i32*, i32** %7, align 8
  call void @drawGen(i32* %44)
  %45 = load i32*, i32** %8, align 8
  store i32* %45, i32** %9, align 8
  %46 = load i32*, i32** %7, align 8
  store i32* %46, i32** %8, align 8
  %47 = load i32*, i32** %9, align 8
  store i32* %47, i32** %7, align 8
  br label %48

48:                                               ; preds = %41
  %49 = load i32, i32* %4, align 4
  %50 = add i32 %49, 1
  store i32 %50, i32* %4, align 4
  br label %38, !llvm.loop !9

51:                                               ; preds = %38
  ret i32 0
}

declare dso_local i32 @simRand(...) #1

declare dso_local void @simInit(...) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
!7 = distinct !{!7, !3}
!8 = distinct !{!8, !3}
!9 = distinct !{!9, !3}
