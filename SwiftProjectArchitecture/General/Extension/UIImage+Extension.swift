//
//  UIImage+Extension.swift
//  点点汇
//
//  Created by wushiqi on 2017/11/23.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import UIKit

extension UIImage{


    /**
     *  压缩上传图片到指定字节
     *
     *  image     压缩的图片
     *  maxLength 压缩后最大字节大小
     *
     *  return 压缩后图片的二进制
     */
    func compressImage(with maxLength: Int) -> UIImage? {

        let newSize =  scaleImage(image: self, imageLength: 300)
        let newImage = resizeImage(image: self, newSize: newSize)

        var compress:CGFloat = 0.9
        let data = UIImageJPEGRepresentation(newImage, compress)
        
        guard var finalData = data else {
            return nil
        }
        
        while (finalData.count) > maxLength && compress > 0.01 {
            compress -= 0.02
            finalData = UIImageJPEGRepresentation(newImage, compress)!
        }

        return UIImage.init(data: finalData)
    }

    /**
     *  通过指定图片最长边，获得等比例的图片size
     *
     *  image       原始图片
     *  imageLength 图片允许的最长宽度（高度）
     *
     *  return 获得等比例的size
     */
    func  scaleImage(image: UIImage, imageLength: CGFloat) -> CGSize {

        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = image.size.width
        let height = image.size.height

        if (width > imageLength || height > imageLength){

            if (width > height) {

                newWidth = imageLength;
                newHeight = newWidth * height / width;

            }else if(height > width){

                newHeight = imageLength;
                newWidth = newHeight * width / height;

            }else{

                newWidth = imageLength;
                newHeight = imageLength;
            }

        }
        return CGSize(width: newWidth, height: newHeight)
    }

    /**
     *  获得指定size的图片
     *
     *  image   原始图片
     *  newSize 指定的size
     *
     *  return 调整后的图片
     */
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

}
