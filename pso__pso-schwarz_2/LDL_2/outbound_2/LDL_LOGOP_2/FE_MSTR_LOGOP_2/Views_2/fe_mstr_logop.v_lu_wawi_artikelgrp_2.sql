CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lu_wawi_artikelgrp_2 (artgrupnr, artgrupbez, artgrupbez_en, lptyp,
lptyp_en, autodispo_flg, wgi, wgi_en) OPTIONS(DESCRIPTION = `WAWI - ARTICLE GROUP AND STORAGE TYPE LOOKUP VIEW`) AS
SELECT *
FROM ldl_logop_data.t_wawi_artikelgrp_mapping_2;