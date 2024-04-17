Features:
* Continue paragraph
* Fact checker


APIs used:
* https://idir.uta.edu/claimbuster/api/
* http://34.224.173.78:8080/docs

1.Introduction:
This project is a text editor that was designed with extensive research into the nuances of text editor design. It implements various features, such as undo/redo functionality and a fact checker, to enhance the user experience. This document provides an overview of the project, the features it offers, and the APIs it uses.

2. Research and Development:
The development of this text editor involved in-depth research on the various data structures used in text editors, such as ropes and piece tables. This research helped in understanding the complexities of text editor design and implementing efficient optimizations.

3. Features:
a. Undo/Redo Functionality:
One of the main features of this text editor is its ability to allow users to undo and redo their actions with a simple click of a button. This was implemented by using a stack data structure to store the changes made by the user and allowing them to reverse or redo these changes.

b. Continue Paragraph:
This feature allows users to continue a paragraph (http://34.224.173.78:8080/docs) on the next line without having to type it all over again. It does this by recognizing a particular pattern of keystrokes and inserting a hard newline character at the end of the current line, making it easier for the user to continue writing. The user can also simply use the graphical UI to send API requests.

c. Fact Checker:
The fact checker feature uses the ClaimBuster API (https://idir.uta.edu/claimbuster/api/) to detect and highlight any potentially false or misleading statements in the text. This helps users to fact-check their writing and ensures the accuracy of their content.

4. APIs used:
Apart from the ClaimBuster API for the fact checker feature, this text editor also uses a custom API for implementing efficient text continuation.

5. Conclusion:
In conclusion, this text editor project is the result of extensive research and development into the complexities of text editor design. Its features, such as undo/redo functionality and the fact checker, enhance the user experience and provide a smooth and efficient writing process. The use of APIs helps in optimizing the performance of the text editor and providing a high-quality service to the users.

![ScreenShot](https://github.com/amadzarak/bayhacks_2024/blob/main/images/screenshot.png)
![ScreenShot](https://github.com/amadzarak/bayhacks_2024/blob/main/images/screenshot2.png)
