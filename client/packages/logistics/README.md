## Getting Started
Add [flutter_riverpod] and it dependencies to your project before adding this package.

If you would be addressing android add this to your manifest

```
<uses-permission android:name="android.permission.INTERNET"/>

```

If you would be addressing sizing cases add this to your top level context

```
SizeConfig().init(context);

```

Then from anywhere in your folder structure you can call:
getProportionateScreenWidth()
getProportionateScreenHeight()

for sizing use.