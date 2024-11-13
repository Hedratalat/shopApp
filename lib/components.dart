import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp_api/layout/news_app/cubit/cubit.dart';
import 'package:shopapp_api/layout/news_app/cubit/states.dart';
import 'package:shopapp_api/modules/web_view/web_view_screen.dart';


Widget defaultButton({
  required double width, // = double.infinity,
  required Color backgroud,
  required Function function,
  required String text,
   bool? isUpperCase, //= Colors.blue
}) =>
    Container(
      width: width,
      color: backgroud,
      child: MaterialButton(
        onPressed: () => function(), // تعديل هنا
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

// تعريف الدالة defaultFormField
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefixIcon,
  required String? Function(String?) validate,
  VoidCallback? onTap, // إضافة خاصية onTap
  bool isClikable = true,
  Function()? suffixPressed,
  IconData? suffixIcon,
  Function(String)? onSubmit,
  bool isPassword = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    validator: validate,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon != null
          ? IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixPressed, // تنفيذ الإجراء عند الضغط على الأيقونة
      )
          : null,
      border: OutlineInputBorder(),
      enabled: isClikable,
    ),
  );
}


Widget buildTaskItem(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          backgroundColor: Colors.black38,

          child: Text(

            '${model['time']}',

            style: TextStyle(

              color: Colors.white,

            ),

          ),

        ),

        SizedBox(width: 20.0,),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                  fontSize: 18.0,

                  fontWeight: FontWeight.bold,

                ),

              ),

              SizedBox(height: 2,),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),



            ],

          ),

        ),

        SizedBox(width: 20.0,),

        IconButton(

          icon: Icon(Icons.check_box,

            color: Colors.cyan,), onPressed: () {



          NewsCubit.get(context).updateDate(status: 'done', id: model['id'],);

        },



        ),

        IconButton(

          icon: Icon(Icons.archive,

            color: Colors.blueGrey,

          ), onPressed: () {

          NewsCubit.get(context).updateDate(status: 'archive', id: model['id'],);



        },



        ),



      ],

    ),

  ),
  onDismissed: (direction){
    NewsCubit.get(context).deletDate(id: model['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) =>  ConditionalBuilder(
  condition: tasks.length >0 ,
  builder:(context) => ListView.separated(
    itemBuilder: (context,index)=> buildTaskItem(tasks[index],context) ,
    separatorBuilder: (context,index) => myDivider(),
    itemCount:tasks.length,
  ),
  fallback: (context) =>Center(
    child: Column(
      mainAxisAlignment:MainAxisAlignment.center ,
      children: [
        Icon(Icons.menu,
          size: 80.0,
          color: Colors.grey,),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),

        )
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticalItem(article,context) => InkWell(
  onTap: (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(article['source_url']),
      ),
    );
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(image:NetworkImage('${article['image_url']}'),
              fit:BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Text(
                  '${article['pubDate']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);


Widget articleBulider(list) =>ConditionalBuilder(
  condition: state is! NewsGetBusinessLoadingState && list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticalItem(list[index],context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length, // استخدم طول القائمة هنا
  ),
  fallback: (context) => Center(
    child: CircularProgressIndicator(color: Colors.teal),
  ),
);

mixin state {
}
void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false,
  );
}

Widget defaultTextButton({
  required Function function,
  required String buttonText,
}) => TextButton(
  onPressed: () => function(),
  child: Text(buttonText.toUpperCase(),style: (TextStyle(
    color: Colors.deepOrangeAccent,
  )),),
);


void showToasts({
  required String text,
  required ToastStates state,
}) =>   Fluttertoast.showToast(
    msg:text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS ,ERROR , WARNING}

 Color chooseToastColor(ToastStates state)
{
Color color;
 switch(state)
 {
   case ToastStates.SUCCESS:
     color = Colors.green;
      break;
   case ToastStates.ERROR:
     color = Colors.red;
     break;

   case ToastStates.WARNING:
     color = Colors.amber;
     break;

 }
    return color;
}