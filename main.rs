//use rand::random;
use std::io;
//use rand ::{thread_rng_Rng};
use std::cmp::ordering;// library
fn main(){
   /*  // input value function
    let mut buffer = string::new();
    io::stdin().read_line(&mut buffer);
    println("Buffer is {}",buffer);*/
    // use random libarray
    /*let number = random::<f64>();
    println("number is {}",number);*/

    // guissing game 
    println!("wlcome to the gussing game");
    let secret_number = rand::thread_rng().gen_range(1..100);// 1 to 100
    //println!("secret number is :{}",secret_number);

    loop{
        println!("please input your guess");
        let mut gues = String::ne();
        io::stdin().read_line(&mut gues)
        .expect("failed to read line");// wrong value
        println!("Your guess:{}",gues);
        let guess:f32 = guess.trim().parse().expect("type in integer");// converting to integer
        //println("{}",guess+1);
    
        match guess.cmp(&secret_number){
            ordering::Less => println!("To small"),
            ordering::Greater=>println!("too big"),
            ordering::Equal=>{
             println!("You win");
             break;
            } 
        }
    }


}