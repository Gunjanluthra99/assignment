class EmpData {
  List<Data> data=[];
  String? status;
  String? message;

  EmpData({required this.data, this.status, this.message});

  EmpData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? employeeAge;
  String? employeeName;
  String? profileImage;
  int? employeeSalary;

  Data(
      {this.id,
        this.employeeAge,
        this.employeeName,
        this.profileImage,
        this.employeeSalary});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeAge = json['employee_age'];
    employeeName = json['employee_name'];
    profileImage = json['profile_image'];
    employeeSalary = json['employee_salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_age'] = this.employeeAge;
    data['employee_name'] = this.employeeName;
    data['profile_image'] = this.profileImage;
    data['employee_salary'] = this.employeeSalary;
    return data;
  }
}
