


bool isValid(titleController, 
         catagoryController,
         descriptionController,
         priceController) {
          
    if (titleController.text == '' ||
        catagoryController.text == '' ||
        descriptionController.text == '' ||
        priceController.text == '') {
      return false;
    }else{
       return true;
    }
  }
