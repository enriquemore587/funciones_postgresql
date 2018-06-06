UPDATE cw.colony SET cp =  CAST('0' || cp AS VARCHAR) WHERE length(cp) = 4;
/*
select count(*) from cw.colony;
select count(*) from cw.colony_copy;
select count(*) from cw.colony_copy where length(cp) <5;
*/