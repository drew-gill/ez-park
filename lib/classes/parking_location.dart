import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DecalType {
  gold,
  silver,
  official,
  orange,
  disabledEmployee,
  disabledStudent,
  blue,
  green,
  medResident,
  shandsSouth,
  staffCommuter,
  carpool,
  motorcycleScooter,
  parkAndRide,
  red1,
  red3,
  brown2,
  brown3,
  visitor,
  none
}

enum DayRestrictions {
  weekends,
  weekdays,
  all,
  none
}

enum LotSize {
  large,
  medium,
  small
}

enum TimeRestrictions {
  standard,
  extended,
  allDay
}

//Corresponds to weekday number from DateTime.weekday
const Set<int> weekdays = <int>{
  1, //monday
  2, //tuesday
  3, //wednesday
  4, //thursday
  5 //friday
};

const Set<int> weekends = <int>{
  6, //saturday
  7 //sunday
};

class ParkingLocation {
  late String name;
  late LatLng location;
  late TimeOfDay restrictionStart;
  late TimeOfDay restrictionEnd;
  late Set<int> restrictedDays;
  late Set<DecalType> requiredDecals;
  late int maxCapacity;
  late int currentOccupancy = 0;


  ParkingLocation(this.name,
      this.location,
      this.restrictionStart,
      this.restrictionEnd,
      this.restrictedDays,
      this.requiredDecals,
      this.maxCapacity);

  ParkingLocation.usingEnums(String locName, LatLng loc, TimeRestrictions timeRestrictions,
      DayRestrictions dayRestrictions, Set<DecalType> reqDecals, LotSize lotSize){
    name = locName;
    location = loc;
    requiredDecals = reqDecals;

    if(timeRestrictions == TimeRestrictions.allDay) {
      restrictionStart = const TimeOfDay(hour: 0, minute: 0);
      restrictionEnd = const TimeOfDay(hour: 23, minute: 59);
    } else if (timeRestrictions == TimeRestrictions.extended) {
      restrictionStart = const TimeOfDay(hour: 7, minute: 30);
      restrictionEnd = const TimeOfDay(hour: 17, minute: 30);
    } else {
      restrictionStart = const TimeOfDay(hour: 8, minute: 30);
      restrictionEnd = const TimeOfDay(hour: 15, minute: 30);
    }

    if (dayRestrictions == DayRestrictions.all) {
      restrictedDays = weekdays.union(weekends);
    } else if (dayRestrictions == DayRestrictions.weekends) {
      restrictedDays = weekends;
    } else if (dayRestrictions == DayRestrictions.weekdays) {
      restrictedDays = weekdays;
    } else {
      restrictedDays = <int>{};
    }

    if (lotSize == LotSize.large) {
      maxCapacity = 500;
    } else if (lotSize == LotSize.medium) {
      maxCapacity = 200;
    } else {
      maxCapacity = 50;
    }
  }

  String decalsToString() {
    if(requiredDecals.isEmpty){
      return "None";
    }

    String decalString = "";

    int decalCount = requiredDecals.length;

    for (var element in requiredDecals) {
      decalString += element.toString().split('.').last;
      decalCount -= 1;
      if(decalCount > 0){
        decalString += ", ";
      }
    }

    return decalString;
  }

  String restrictedDaysToString() {
    if(restrictedDays.isEmpty) {
      return "None";
    }
    List orderedDays = [...restrictedDays];
    orderedDays.sort();

    Map<int, String> dayNameMap = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thur",
      5: "Fri",
      6: "Sat",
      7: "Sun"
    };

    String output = "";

    int dayCount = restrictedDays.length;
    for (var dayNum in orderedDays) {
      output += dayNameMap[dayNum]!;
      dayCount -= 0;
      if(dayCount > 0){
        output += ", ";
      }
    }

    return output;
  }

  String restrictedTimesToString() {
    return restrictionStart.hour.toString() + ":" + restrictionStart.minute.toString()
        + " - " + restrictionEnd.hour.toString() + ":" + restrictionEnd.minute.toString();
  }
}
