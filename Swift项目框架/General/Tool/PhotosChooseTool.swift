//
//  PhotosTool.swift
//  Swift项目框架
//
//  Created by wushiqi on 2017/11/9.
//  Copyright © 2017年 wushiqi. All rights reserved.
//

import Foundation
import YLImagePickerController


class PhotosChooseTool{

    typealias DidFinishChoosingPhotosHandle = (_ chooser :PhotosChooseTool, _ photos: [UIImage]) -> Void
    
    fileprivate var selectedPhotoModels = [YLPhotoModel]()
    var selectedPhotos : [UIImage] { return selectedPhotoModels.filter{ $0.image != nil }.map{ $0.image! }}
    
    fileprivate var maxImagesCount : Int        //总共可选图片张数
    fileprivate var remainderImagesCount : Int{ //剩余可选图片张数
        let temp = maxImagesCount - selectedPhotoModels.count
        return temp < 0 ? 0 : temp
    }
    
    fileprivate var viewController : UIViewController
    var choosingHandle  : DidFinishChoosingPhotosHandle?
    init(maxImagesCount : Int = 6 ,viewController : UIViewController) {
        self.maxImagesCount = maxImagesCount
        self.viewController = viewController
    }
    
}


//MARK: - 相册操作
extension PhotosChooseTool{
    
    @discardableResult
    func open(isSingle : Bool  = false) -> Self {
        
        if( isSingle ){ maxImagesCount = 1 }; //如果是单选,这里将Max改为1
        
        guard remainderImagesCount > 0 else {
            AlertTool.showAlert(message: "最多只能选\(maxImagesCount)张照片", cancel: nil, other: nil)
            return self
        }
        
        
        var imagePicker : YLImagePickerController?
        
        let camera = AlertHandel.handel(withTitle: "拍照") {[unowned self ] in
            imagePicker = YLImagePickerController.init(imagePickerType: ImagePickerType.camera, cropType: CropType.none)
            self.handleImagePickeVC(imagePicker: imagePicker)
            self.viewController.present(imagePicker!, animated: true, completion: nil)
        }
        
        let album = AlertHandel.handel(withTitle: "从相册选取") {[unowned self ] in
            if( isSingle ){
                imagePicker = YLImagePickerController.init(imagePickerType: ImagePickerType.album, cropType: CropType.none)
            }else{
                imagePicker = YLImagePickerController.init(maxImagesCount: self.remainderImagesCount)
            }
            self.handleImagePickeVC(imagePicker: imagePicker)
            self.viewController.present(imagePicker!, animated: true, completion: nil)
        }
    
        AlertTool.showSheet(message: "选择方式", other: [camera,album])
        return self
    }
    
    //处理相册回调
    fileprivate func handleImagePickeVC( imagePicker : YLImagePickerController? ){
    
        imagePicker?.didFinishPickingPhotosHandle = {[unowned self ](photos: [YLPhotoModel]) in
            
            let temp = photos.filter{$0.type == YLAssetType.photo}
            if( temp.count > 0 ){
                 self.selectedPhotoModels.append(contentsOf: temp)
                 self.choosingHandle?(self,self.selectedPhotos)
            }
        }
    }
}


//MARK: - 逻辑处理
extension PhotosChooseTool{
    
    //删除选中图片
    func deletePhoto(at index : Int){
       guard index >= selectedPhotoModels.count else {return  }
       selectedPhotoModels.remove(at: index)
       self.choosingHandle?(self,self.selectedPhotos)
    }
    func deletePhoto(with image : UIImage){
        if let index = selectedPhotoModels.index(where: { $0.image == image }){
            selectedPhotoModels.remove(at: index)
            self.choosingHandle?(self,self.selectedPhotos)
        }
    }
}

