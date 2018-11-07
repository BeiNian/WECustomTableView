# WECustomTableView
使用方法：

1、将 WECustomTableView文件夹拖入项目。

2、要使用的控制器继承 WECustomTableViewController，U对应的viewModel 继承WECustomTableViewModel。

3、调用- (void)configurationTableViewStyle: viewModel:创建一个tableView并传入对应的ViewModel。

4、重写 - (UITableViewCell *)tableView:dequeueReusableCellWithIdentifier: forIndexPath:和- (void)configureCell: atIndexPath: withObject: 方法。创建对应的cell和cell赋值。


