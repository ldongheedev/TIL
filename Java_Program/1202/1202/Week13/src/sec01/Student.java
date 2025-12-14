package sec01;

class Student {
    String photo, id, name; // 사진, 학번, 이름
    int mid, fin; // 중간고사, 기말고사

    Student(String photo, String id, String name, int mid, int fin) {
        this.photo = photo;
        this.id = id;
        this.name = name;
        this.mid = mid;
        this.fin = fin;
    }
    
    //메소드 추가 : 합계, 평균,...
    // 합계 점수
    int getTotal() {
    	int total = mid + fin;
        return total;
    }

    // 평균 점수
    double getAvg() {
        double avg = getTotal() / 2.0;
        return avg;
    }
    
}
