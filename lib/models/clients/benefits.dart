//enum Coverage { AssistanceOnly, Covered }

import 'package:json_annotation/json_annotation.dart';
part 'benefits.g.dart';

@JsonSerializable()
class Benefits {
  final int hospitalizationInsurance;
  final int tripsToEmergencyRoom;
  final int medicalEvacuation;
  final int emergencyDentalCare;
  final int treatmentForInPatientCare;
  final int mentalHealth;
  final int prescriptionDrugs;

  Benefits(
      {this.hospitalizationInsurance,
      this.tripsToEmergencyRoom,
      this.medicalEvacuation,
      this.emergencyDentalCare,
      this.treatmentForInPatientCare,
      this.mentalHealth,
      this.prescriptionDrugs});

  factory Benefits.fromJson(Map<String, dynamic> json) => _$BenefitsFromJson(json);
  Map<String, dynamic> toJson() => _$BenefitsToJson(this);


  @override
  String toString() {
    return 'Benefits{hospitalizationInsurance: $hospitalizationInsurance, tripsToEmergencyRoom: $tripsToEmergencyRoom, medicalEvacuation: $medicalEvacuation, emergencyDentalCare: $emergencyDentalCare, treatmentForInPatientCare: $treatmentForInPatientCare, mentalHealth: $mentalHealth, prescriptionDrugs: $prescriptionDrugs}';
  }

  List<Map<String, dynamic>> toList() {
    return [
      {'Hospitalization Insurance': hospitalizationInsurance},
      {'Trips To EmergencyRoom': tripsToEmergencyRoom},
      {'Medical Evacuation': medicalEvacuation},
      {'Emergency DentalCare': emergencyDentalCare},
      {'Treatment For InPatientCare': treatmentForInPatientCare},
      {'MentalHealth': mentalHealth},
      {'PrescriptionDrugs': prescriptionDrugs},

    ];
  }
}

//String coverageToString(Coverage coverage) {
//  return (coverage == Coverage.Covered) ? 'Covered' : 'Assistance only';
//}
