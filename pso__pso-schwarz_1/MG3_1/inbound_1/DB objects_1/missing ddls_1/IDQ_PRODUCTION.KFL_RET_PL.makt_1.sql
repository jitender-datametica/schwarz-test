create or replace view `daia-d-sdi-sdiidq-0.kfl_ret_pl.makt_1`(
        mandt,
        matnr,
        spras,
        maktx,
        maktg,
        country_code,
        td_insert,
        td_update
) as select
        mandt,
        matnr,
        spras,
        maktx,
        maktg,
        country_code,
        td_insert,
        td_update
from kfl_ret.makt_1 
 where country_code in ('PL','pl')and spras!='묩';
