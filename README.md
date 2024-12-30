
# E-commerce app with Flutter Dart and Firebase

## This E-commerce project is for the admin and there is another app for user to interect with the shop [user app](https://github.com/abdulawalarif/user_app.git)
  
**It's a fully fledged application for small business**



## Features
* **Authentication:** Google And Email Password. 
* **Products :**
  - Product (CRUD)
  - Caterorizing product
  - Deatailed view
  - Multiple image and choosing thumnail and editing it later
  - Effecient data handeling in storage during delete and update

* **Order Management**
  - Sending different status of product to the client app.
* **User management :**
- Users details view with map by geo location(lat and lon)

* **Theaming :**   
  - Dark and Light 


## File structure

    
    ├── lib
    │   ├── core  
    │   │  ├── models 
    │   │  ├── providers => all the interections with database
    │   │── ui
    │   │  ├── constants
    │   │  ├── screens
    │   │  ├── utils
    │   │  ├── widgets
    │   ├── main.dart                  
     
 
<img src="ProjectSnap/light_theme/1.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/2.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/3.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/4.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/5.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/6.jpg" width="15%" alt="OrderPlacing first step" /><img src="ProjectSnap/light_theme/7.jpg" width="15%" alt="order confirmed" /><img src="ProjectSnap/light_theme/8.jpg" width="15%" alt="Registration Form" /><img src="ProjectSnap/light_theme/9.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/10.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/11.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/12.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/13.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/14.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/15.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/16.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/17.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/18.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/19.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/20.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/21.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/22.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/23.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/24.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/25.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/26.jpg" width="15%" alt="Demo of this application" /><img src="ProjectSnap/light_theme/27.jpg" width="15%" alt="Demo of this application" />


<img src="ProjectSnap/light_theme/28.jpg" width="15%" alt="Demo of this application" />
</br>

 
# You can take a Look at the project [More Images here..](images.md).



 

## Run Locally

Clone the project

```bash
  git clone https://github.com/abdulawalarif/user_app.git
```

Go to the project directory

```bash
  cd user_app
```

Install dependencies

```bash
  flutter pub get
```

Connect a physical device or start a virtual device on your machine

```bash
  flutter run
```



## How to tweak this project for your own uses
* **Setup Firebase:** Insert some data for testing..


 

## Reporting Bugs or Requesting Features?

If you found an issue or would like to submit an improvement to this project,
please submit an issue using the issues tab above. If you would like to submit a PR with a fix, reference the issue you created!

##  Known Issues and Future Work
* **CRUD for product category:** Future improvements could include fetching the product categories from the network.
 * **Image uploding:** Making the images dragable for arranging and re-arranging.
* **Improved Error Handling:** The current implementation focuses on successful responses. Implementing comprehensive error handling for failed network requests would make the app more robust.
 
* **Adding payment method:** Online payment integrations. 
  
## Author

- [@abdulawalarif](https://github.com/abdulawalarif) 
- This project is cloned from this [StoreApp](https://github.com/nur4nnis4/store_app)
  
## License


The MIT License [MIT](https://choosealicense.com/licenses/mit/). Please view the [License](LICENSE) File for more information.
