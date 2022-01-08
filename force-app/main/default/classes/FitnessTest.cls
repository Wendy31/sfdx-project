@isTest
public class FitnessTest {
    
    // bmi unit test methods
    // postive test: using positive inputs
    @isTest
    public static void calculateBMIPosTest(){
        Fitness wendysFitness = new Fitness();
        Decimal bmi = wendysFitness.calculateBMI(53, 1.3);
        
        System.assertEquals(31.36, bmi);
    }
    
    // negative test: weight has 0 value
    @isTest
    public static void calculateBMIWithZeroWeight(){
        Fitness wendysFitness = new Fitness();
        Decimal bmi = wendysFitness.calculateBMI(0, 1.3);
        
        System.assertEquals(0, bmi);   
    }
    
    // negative test: height has 0 value
    @isTest
    public static void calculateBMIWithZeroHeight(){
        Fitness wendysFitness = new Fitness();
        Decimal bmi = wendysFitness.calculateBMI(53, 0);
        
        System.assertEquals(-1, bmi, 'Invalid input');  
    }
    
    // negative test: weight has negative value
    @isTest
    public static void calculateBMIWithNegativeWeight(){
        Fitness wendysFitness = new Fitness();
        Decimal bmi = wendysFitness.calculateBMI(-53, 1.3);
        
        System.assertEquals(-1, bmi, 'Invalid input');
    }
    
    // negative test: height has negative value
    @isTest
    public static void calculateBMIWithNegativeHeight(){
        Fitness wendysFitness = new Fitness();
        Decimal bmi = wendysFitness.calculateBMI(53, -1.3);
        
        System.assertEquals(-1, bmi, 'Invalid input');
    }
    
    
    // pace unit test methods
    // postive test: using positive inputs
    @isTest
    public static void calculatePaceTest(){
        Fitness wendysFitness = new Fitness();
        Decimal pace = wendysFitness.calculatePace(3, 20);
        
        System.assertEquals(9, pace);  
    }
    
    // negative test: distance has negative value
    @isTest
    public static void calculatePaceWithNegativeDistance(){
        Fitness wendysFitness = new Fitness();
        Decimal pace = wendysFitness.calculatePace(-3, 20);
        
        System.assertEquals(-1, pace); 
    }
    
    // negative test: minute has negative value
    @isTest
    public static void calculatePaceWithNegativeMinute(){
        Fitness wendysFitness = new Fitness();
        Decimal pace = wendysFitness.calculatePace(3, -20);
        
        System.assertEquals(-1, pace); 
    }
    
    // negative test: distance has 0 value
    @isTest
    public static void calculatePaceWithZeroDistance(){
        Fitness wendysFitness = new Fitness();
        Decimal pace = wendysFitness.calculatePace(0, 20);
        
        System.assertEquals(0, pace); 
    }
    
    // negative test: minute has 0 value
    @isTest
    public static void calculatePaceWithZeroMinute(){
        Fitness wendysFitness = new Fitness();
        Decimal pace = wendysFitness.calculatePace(3, 0);
        
        System.assertEquals(-1, pace); 
    }
    
}