import 'package:test/test.dart';

import 'package:color_transition/color_transition.dart';

void main() {
	test('adds one to input values', () {
		ColorTransition colorTransition;
		colorTransition = new ColorTransition(callback: (currentColor){
			expect(currentColor.runtimeType.toString(), 'List<int>');
			colorTransition.cancel();
		}).init();
	});
}
