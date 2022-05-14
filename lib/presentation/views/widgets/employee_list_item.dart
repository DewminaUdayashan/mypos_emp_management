import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const itemRadius = 13.0;

class EmployeeListItem extends StatelessWidget {
  const EmployeeListItem(this.index, {Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 16.w,
        left: 20.w,
        right: 20.w,
        top: index == 0 ? 250.h : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(itemRadius.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(itemRadius.r),
        child: Material(
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(itemRadius.r),
            splashColor: Colors.blueGrey.withOpacity(.3),
            highlightColor: Colors.transparent,
            child: Ink(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 450.h,
                      child: Image.network(
                        'https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 450.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '✔️​ 01',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '🙋‍♂️​ Jhon Doe',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '🎂​ 01/01/1001',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '📱​ 0765209703',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ]),
                          ),
                          Row(
                            children: [
                              ChoiceChip(
                                label: Text(
                                  'Permenent',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                selected: true,
                                selectedColor: Colors.greenAccent,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
