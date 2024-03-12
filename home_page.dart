void moveSnake(){
    switch (currentDirection){
        case snake_Direction.RIGHT:
        {
            //add a head
            //if snake is at right wall,need to re-adjust
            if(snakePos.last%rowSize==9){
                snakePos.add(snakePos.last+1-rowSize);
            }else{
                snakePos.add(snakePos.last+1);
            }   
            
            
        }

        break;
        case snake_Direction.LEFT:
        {
             //add a head
            //if snake is at right wall,need to re-adjust
            if(snakePos.last%rowSize==0){
                snakePos.add(snakePos.last-1+rowSize);
            }else{
                snakePos.add(snakePos.last-1);
            } 

            
        }
        break;
        case snake_Direction.UP:
        {
             //add a head
         
            if(snakePos.last<rowSize){
                snakePos.add(snakePos.last-rowSize+totalNumberOfSquares);
            }else{
                snakePos.add(snakePos.last-rowSize);
            } 

           
        }
        break;
        case snake_Direction.DOWN:
        {
             //add a head
             if(snakePos.last+rowSize > totalNumberOfSquares){
                snakePos.add(snakePos.last+rowSize-totalNumberOfSquares);
            }else{
                snakePos.add(snakePos.last+rowSize);
            } 

            
        }
        break;
        default:
    }
    // snake is eating food
    if(snakePos.last==foofPos){
        eatFood();
    }else{
        // remove tail
        snakePos.removeAt(0);
    }
}










void eatFood(){
    while(snakePos.contains(foodPos)){
        foodPos=Random().nextInt(totalNumberOfSquares);

    }
}



bool gameOver(){
    //the game is over when the snake runs into itself
    //this occur when there is a duplicate position in snakePos list
    //this list is the body of the snale(no head)
    List<int> bodySnake=snakePos.sublist(0,snakePos.length-1);
    if(bodySnake.contains(snakePos.last)){
        return true;
    }
    return false;

}



void submitScore(){

}


void newGame(){
    setState(() {
        snakePos=[
            0,
            1,
            2,
        ];
        foodPos=55;
        currentDirection=snake_Direction.RIGHT;
        gameHasStarted=false;
        currentScore=0;
    });
}