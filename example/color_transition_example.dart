// Copyright (c) 2018, RiftNinja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:color_transition/color_transition.dart';

main() {
	List<int> initialColor = [255, 255, 255];

	ColorTransition colorTransition;
	colorTransition = new ColorTransition(
		currentColor: initialColor, fps: 30,
		duration: 3, callback: (currentColor){
			print(currentColor);
			colorTransition.cancel();
		}
	);

	print(colorTransition.generateRGB());
	colorTransition.init();
}