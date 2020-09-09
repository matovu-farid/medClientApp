// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Benefits _$BenefitsFromJson(Map<String, dynamic> json) {
  return Benefits(
    hospitalizationInsurance: json['hospitalizationInsurance'] as int,
    tripsToEmergencyRoom: json['tripsToEmergencyRoom'] as int,
    medicalEvacuation: json['medicalEvacuation'] as int,
    emergencyDentalCare: json['emergencyDentalCare'] as int,
    treatmentForInPatientCare: json['treatmentForInPatientCare'] as int,
    mentalHealth: json['mentalHealth'] as int,
    prescriptionDrugs: json['prescriptionDrugs'] as int,
  );
}

Map<String, dynamic> _$BenefitsToJson(Benefits instance) => <String, dynamic>{
      'hospitalizationInsurance': instance.hospitalizationInsurance,
      'tripsToEmergencyRoom': instance.tripsToEmergencyRoom,
      'medicalEvacuation': instance.medicalEvacuation,
      'emergencyDentalCare': instance.emergencyDentalCare,
      'treatmentForInPatientCare': instance.treatmentForInPatientCare,
      'mentalHealth': instance.mentalHealth,
      'prescriptionDrugs': instance.prescriptionDrugs,
    };
