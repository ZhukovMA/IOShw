//
//  MyButton.swift
//  swift_lesson1_2
//
//  Created by 16817252 on 16/10/2019.
//  Copyright © 2019 16817252. All rights reserved.
//

import UIKit

class MyButton: UIButton {

	override func point(inside: CGPoint, with: UIEvent?) -> Bool {
		
		let maxX = self.bounds.maxX + 30.0
		let maxY = self.bounds.maxY + 30.0
		let minX = self.bounds.minX - 30.0
		let minY = self.bounds.minY - 30.0
		
		if (inside.x < maxX &&
			inside.x > minX &&
			inside.y < maxY &&
			inside.y > minY)
		{
			return true
		}
		else
		{
			return false
		}
	}
}
