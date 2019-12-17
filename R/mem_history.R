# # library(tidyverse)
#  history <- data.frame(time=seq(from=Sys.time(),length.out = 100,by = "1 sec"),
#                          mem_used = runif(100,0,10))


nice_units <- function (x, digits = 3, ...) 
 {
   power <- min(floor(log(abs(x), 1000)), 4)
   power <- floor(log(abs(x), 1000))
   power[power>4]<-4
   power[power<1]<-1
   power[is.na(power)]<-1
   power

     unit <- c("B","kB", "MB", "GB", "TB")[power+1]
     x <- x/(1000^power)
   formatted <- format(signif(x, digits = digits), big.mark = ",", 
                       scientific = FALSE)
   # cat(formatted, " ", unit, "\n", sep = "")
   paste(formatted,unit)
   
 }
#' @import ggplot2
#' @import dplyr
#' @importFrom  lubridate round_date
#' 
#' 

mem_history <- function(history){
  
  history <- history %>% 
    mutate(
    y = floor(mem_used/100000),
    y2=lag(y)) %>% 
    filter(y!=y2) %>% 
    bind_rows(history %>% slice(n())) %>% 
    select(time,  mem_used)
  
  
 history2 <-  bind_rows(old = history, 
            new = history %>% 
              mutate(mem_used = lag(mem_used)),
            .id = "source") %>%
    arrange(time, source)
  

  # base <- data.frame(time =   seq(from=min(history$time),to=max(history$time),by="1 sec"))
  #   history2 %>% 
  #   # full_join(base,by="time") %>% 
  #   # arrange(time) %>% 
  #     # mutate(mem_used = zoo::na.approx(mem_used)) %>% 
  #   group_by(time=lubridate::round_date(time,"1 seconds")) %>% 
  #   summarise(mem_used=mean(mem_used,na.rm=TRUE)) %>% 
  # ggplot() +
  # aes(x=time, y =mem_used) +
  # # geom_line(linetype = 2,size=1) + 
  # # geom_point(shape=15, size = 3, stroke = 3) +
  #   geom_step()+
  # geom_area(fill=alpha('slateblue',0.2)) +
  # theme_classic()+
  # scale_y_continuous(labels =nice_units)+
  # theme(axis.line = 
  # element_line(linetype = "dashed"))
 # save(history,history2,file="plop.Rdata")
 # load("inst/app/plop.Rdata")
 history %>% 
 ggplot( ) + aes(time,mem_used) +
   geom_ribbon(aes(x = time, ymin = 0, 
                   ymax = mem_used), 
               data = history2,
               fill = alpha('slateblue',0.2))+
   theme_classic()+
   scale_y_continuous(labels =nice_units)+
   theme(axis.line =
   element_line(linetype = "dashed"))+
   geom_step(
     lty = 3,
             shape=15, 
     size = 4,
     stroke = 1,
     linemitre = 2
     )
 
 
 
 
}
