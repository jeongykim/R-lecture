num <- 5
for (i in 1:(num*2-1)){
  if(i <= 5){
    for(j in 1:(num-i)){
      if(num-i>0) cat(" ")
    }
    for (j in 1:(i*2-1)){
      cat("+")
    }
    cat("\n")
  } else {
    for (j in 1:(i-num)){
      cat(" ")
    }
    for(j in 1:((num*2-i)*2-1)){
      cat("+")
    }
    cat("\n")
  }
}
