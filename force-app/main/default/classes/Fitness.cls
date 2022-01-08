public class Fitness {
    
    // class variables
    Decimal weight;
    Decimal height;
    Decimal distance;
    Decimal minutes;
    
    // define constructor for BMI
    /*public Fitness(Decimal weight, Decimal height, Decimal distance, Decimal minutes){
this.weight = weight;
this.height = height;
this.distance = distance;
this.minutes = minutes;

} */
    
    // method to calculate BMI and returns BMI value
    // BMI formula: (body weight in kg)/ (body height in meter)2
    public Decimal calculateBMI(Decimal weight, Decimal height){
        Decimal bmi;
        if(weight == 0){
            bmi = 0; // redundant: divided by 0 will result in 0 anyway
        } else if (weight < 0 || height <= 0){
            bmi = -1;
        } else {
            bmi = weight/ (height * height);
            
        }
        return bmi.setScale(2); // no need to assign values to global bmi, can use return statement in each condition instead (see refactor code below)
    }
    
    // method to calc Pace and returns Km per hour
    // pace formula: (distance in km)/ (time in minutes) 
    // convert km per min to km perhr
    public Decimal calculatePace(Decimal distance, Decimal minutes){
        if(distance < 0 || minutes <= 0){
            return -1; 
        } 
        Decimal kmPerMin = distance/ minutes;
        Decimal kmPerHr  = kmPerMin * 60;
        return kmPerHr.setScale(2);
    } 
}