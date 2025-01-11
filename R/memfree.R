#' @importFrom ps ps_system_memory

mem_info <-function(){
  # out<-  lapply(ps::ps_system_memory(),function(x){x/(1024^3)})
  out<-  ps::ps_system_memory()

  # out$percent <- out$used/out$total
  out
  }
