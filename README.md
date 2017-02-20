# UISkipControl
本库，是为了解决iosUIViewController跳转产生的crash，包括

1.UINavigationController的push pop

2.UIViewController的dissmiss present

系统在跳转过程中不会禁止其他的跳转，所以我们需要限制起来，防止多次跳转产生crash。
一、解决方案和原理
1.将所有的跳转管理起来
    将所有的跳转进行管理，只允许一个window上的跳转同一时刻只能进行一次
例如
[self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
[self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
加入本库后，这样的代码，第二行的会失败。因为同时进行两个跳转。
2.增加完成block
为了避免上面的第二行失败，同时满足业务要求，增加push完成回调，帮助完成push完成后的跳转
[self.navigationController pushViewController:[[UIViewController alloc] init]  animated:YES isAllowQueued:NO completionBlock:^{
[self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}];
其中isAllowQueued 表示是 在不能立刻进行跳转的情况下 是否将当前操作加入到队列，以便没有跳转操作时进行（意思就是增加了跳转队列）。
增加了completionBlock以便跳转跳转完成后进行二次跳转。
3.增加跳转队列
上面代码中的isAllowQueued，如何使用呢？
比如
[self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
[self.navigationController pushViewController:[[UIViewController alloc] init]  animated:YES isAllowQueued:YES completionBlock:nil];
将第二个增加到队列中isAllowQueued为YES,这样也可以避免第二个失败。
