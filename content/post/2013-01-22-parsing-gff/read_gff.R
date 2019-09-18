require(Rcpp)
require(GenomicRanges)
sourceCpp('read_gff.cpp')
read_gff = function(file, grouping='feature_id', attribute_sep='=') {
  data = data.frame(lapply(gff2df(file, attribute_sep), all_numeric, what="vector"))
  if(!grouping %in% colnames(data)){
    stop(paste(grouping, "does not exist in", file, ", valid columns are", paste(colnames(data), collapse=" ")))
  }
  stopifnot(grouping %in% colnames(data))
  lapply(split(data, factor(data$seqid)), function(df) {
         split(GRanges( ranges=IRanges( start=df$start, end=df$end),
                       seqnames=df$seqid,
                       strand=df$strand,
                       mcols = df[, !colnames(df) %in% c("seqid", "strand", "start", "end") ]
                       ), df[,grouping], drop=TRUE)
                                     })
}
#from Hmisc library
all_numeric = function (x, what = c("test", "vector"), extras = c(".", "NA")) {
  what <- match.arg(what)
  old <- options(warn = -1)
  on.exit(options(old))
  x <- sub("[[:space:]]+$", "", x)
  x <- sub("^[[:space:]]+", "", x)
  xs <- x[! x %in% c("", extras)]
  isnum <- !any(is.na(as.numeric(xs)))
  if (what == "test"){
    isnum
  }
  else if (isnum){
    as.numeric(x)
  }
  else {
    x
  }
}
