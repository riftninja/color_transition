library color_transition;

import 'dart:async';
import 'dart:math';

class ColorTransition {
	ColorTransition({ this.currentColor, this.fps: 30, this.duration: 3, this.callback });
	List<int> currentColor;
	final Function callback;
	final int duration;
	final int fps;

	///* ==================== Setup ==================== */
	// List<int> initialColor;
	List<int> _targetColor;
	List<int> _increment;
	Timer _transHandler;

	///* ==================== Transition Initiator ==================== */
	ColorTransition init(){
		// if(initialColor == null) initialColor = currentColor;

		_transHandler?.cancel();
		currentColor = (currentColor != null) ? currentColor : [255, 255, 255];

		_targetColor = generateRGB();
		// print(duration.toString()+' => '+_targetColor.toString());
		List<int> distance = _calculateDistance(currentColor, _targetColor);
		_increment = _calculateIncrement(distance, fps, duration); // changed from fps
		_transHandler = new Timer.periodic(new Duration(milliseconds: (1000/fps).round()), (timer) {
			_transition();
			if(callback != null)
				callback(currentColor);
		});
		return this;
	}

	void cancel(){
		_transHandler.cancel();
	}

	/// A function to generate random numbers.
	/// Will be needed to generate random RGB value between 0-255.
	int _random(int min, int max) {
		return ((new Random()).nextDouble() * (max - min) + min).round();
	}

	/// Generates a random RGB value.
	List<int> generateRGB({int min, int max}) {
		List<int> color	= [];
		max = min != null ? min : 255;
		min = min != null ? min : 0;
		for (int i = 0; i < 3; i++) {
			int num = _random(min, max);
			color.add(num);
		}
		return color;
	}

	/// Calculates the distance between the RGB values.
	/// We need to know the distance between two colors
	/// so that we can calculate the _increment values for R, G, and B.
	List<int> _calculateDistance(colorArray1, colorArray2) {
		List<int> distance = [];
		for (int i = 0; i < colorArray1.length; i++) {
			distance.add((colorArray1[i] - colorArray2[i]).abs());
		}
		return distance;
	}

	/// Calculates the _increment values for R, G, and B using distance, fps, and duration.
	/// This calculation can be made in many different ways.
	List<int> _calculateIncrement(distanceArray, fps, duration) {
		List<int> _increment	= [];
		for (int i = 0; i < distanceArray.length; i++) {
			int incr = ((distanceArray[i] / (fps * duration)).floor()).abs();
			if (incr == 0) {
				incr = 1;
			}
			_increment.add(incr);
		}
		return _increment;
	}

	///* ==================== Transition Calculator ==================== */
	void _transition() {
		// checking R
		if (currentColor[0] > _targetColor[0]) {
			currentColor[0] -= _increment[0];
			if (currentColor[0] <= _targetColor[0]) {
				_increment[0] = 0;
			}
		} else {
			currentColor[0] += _increment[0];
			if (currentColor[0] >= _targetColor[0]) {
				_increment[0] = 0;
			}
		}

		// checking G
		if (currentColor[1] > _targetColor[1]) {
			currentColor[1] -= _increment[1];
			if (currentColor[1] <= _targetColor[1]) {
				_increment[1] = 0;
			}
		} else {
			currentColor[1] += _increment[1];
			if (currentColor[1] >= _targetColor[1]) {
				_increment[1] = 0;
			}
		}

		// checking B
		if (currentColor[2] > _targetColor[2]) {
			currentColor[2] -= _increment[2];
			if (currentColor[2] <= _targetColor[2]) {
				_increment[2] = 0;
			}
		} else {
			currentColor[2] += _increment[2];
			if (currentColor[2] >= _targetColor[2]) {
				_increment[2] = 0;
			}
		}

		// transition ended. start a new one
		if (_increment[0] == 0 && _increment[1] == 0 && _increment[2] == 0) {
			// currentColor = initialColor;
			init();
		}
	}
}
