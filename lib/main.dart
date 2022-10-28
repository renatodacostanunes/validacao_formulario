import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_strength_checker/controller.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainView(),
  ));
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(
        () => Scaffold(
            appBar: AppBar(
              backgroundColor: c.color.value,
              title: const Text('@renatodacostanunes'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => c.checkPassword(value),
                    obscureText: c.isObscure.value,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: c.color.value, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            c.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              c.isObscure.value = !c.isObscure.value,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: 'Password'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  LinearProgressIndicator(
                    value: c.strength.toDouble(),
                    backgroundColor: Colors.grey[300],
                    color: c.color.value,
                    minHeight: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    c.displayText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: c.color.value),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: c.strength.value < 0.50 ? null : () {},
                    style: ButtonStyle(
                      backgroundColor: c.strength.value < 0.50
                          ? null
                          : MaterialStateProperty.all(
                              c.color.value,
                            ),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
