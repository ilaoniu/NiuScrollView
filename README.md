# NiuScrollView

UIScrollView循环滚动，滚动视图复用，图片说明文字可选，pageControl、Label位置可自定义

使用方法：

NiuScrollView *scrollView = [[NiuScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 150)];

NiuDataModel *dataModel = [[NiuDataModel alloc]initWithImageNameAndTitleArray];

scrollView.imageNameArray = dataModel.imageNameArray;

scrollView.PageControlShowStyle = UIPageControlShowStyleRight;

[scrollView setTitleArray:dataModel.titleArray withShowStyle:TitleShowStyleLeft];

scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];

scrollView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];

[self.view addSubview:scrollView]; 