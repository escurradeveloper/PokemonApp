# Proyecto de IOS con Swift UIKit consumiendo la API de pokemons
Aplicación Pokemon App. Aplicación móvil en IOS con Swift en UIKit. 
El código fuente se puede descargar en el branch "develop". Esta aplicación consiste en consumir un listado de la API de Pokemon. Podemos buscar por el nombre del pokemon y ver su detalle en donde se encuentra su información como peso, altura, tipos y evoluciones. 

Tecnologías: 

UIKit. 
Swift. 
xCode 16.0. 
Switf Package Manager en donde se usa la librería AlamofireImage para la visualización de las imagenes de los pokemones.
Design Pattern: Inyección de dependencia, patrón repository para la data local, patrón singleton, patron builder para construir paso a paso los componentes de la UI como labels, imagenes, etc. 
Vistas programáticas - Constraints. 
UITableViewDiffableDataSource. 
UISearchController. 
UIView, UILabel, UIStackView, UIScrollView. 
Pruebas Unitarias - Unit Tests. 
CoreData para el almacenamiento local. 

Arquitectura VIPER: 
V = Vista (interfaz de usuario). 
I = Interactor (llamada a servicios). 
P = Presenter (lógica de negocio). 
E = Entity (entidades, modelos). 
R = Router (navegación entre pantallas). 

Esta aplicación tiene sus clases y/o carpetas de acuerdo a dicha arquitectura. 

<img width="487" alt="viper-arquitectura-de-la-app" src="https://github.com/user-attachments/assets/e23caa89-a873-4cd2-9811-f8077b4de376" />


Capturas de la aplicación: 

<img width="210" alt="view1" src="https://github.com/user-attachments/assets/d731fd87-4286-40f4-89e2-48540672f133" />
<img width="217" alt="view2" src="https://github.com/user-attachments/assets/827ce18b-56f4-40b7-83e9-f7358885ebfc" />
<img width="209" alt="view3" src="https://github.com/user-attachments/assets/e64742af-dd03-4e18-b6ad-80c26623a484" />
<img width="213" alt="view4" src="https://github.com/user-attachments/assets/1e5e64b5-c6e0-45f8-8a81-3059566981fe" />
<img width="214" alt="view5" src="https://github.com/user-attachments/assets/5dac03c7-2b07-46c5-b5bc-7b5d8c0a1cf0" />
<img width="215" alt="view6" src="https://github.com/user-attachments/assets/af458fee-b773-4de7-b9a8-1728e872b9e2" />
<img width="215" alt="view7" src="https://github.com/user-attachments/assets/8a61afb4-f3d0-4a67-9e1c-30342de2a962" />
<img width="214" alt="view8" src="https://github.com/user-attachments/assets/51920058-1218-4590-84d7-891cb45016f3" />
<img width="215" alt="view9" src="https://github.com/user-attachments/assets/e2b08399-03a5-4921-857c-492d9875e23d" />
<img width="215" alt="view10" src="https://github.com/user-attachments/assets/8f5f6d90-0035-4589-8320-2fa526621f38" />
