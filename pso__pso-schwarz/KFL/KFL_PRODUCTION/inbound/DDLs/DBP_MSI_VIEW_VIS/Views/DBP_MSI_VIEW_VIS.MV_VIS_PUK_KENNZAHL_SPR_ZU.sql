CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_PUK_KENNZAHL_SPR_ZU
AS
    -- SPR/LU : PUK Kennzahl
    -- 2019.0730 INITIAL 
    -- 2020.0124 ssch0611 : Thema added

   SELECT
     kzs.kennzahl_id, lkz.thema_id, /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
	  Max(CASE WHEN spr_id =  22 THEN kennzahl_bez ELSE Trim(kzs.kennzahl_id) END) AS kennzahl_bez_de,
 kennzahl_bez_de                                                              AS kennzahl_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN kennzahl_bez END), /*Conversion issue - Severity Medium - 'kennzahl_bez_de' has recursive references. Forward alias conversion could not be completed*/
 kennzahl_bez_de) AS kennzahl_bez_bg    -- BG
   
   FROM dbp_data.vis_puk_kennzahl_spr_zu kzs

   JOIN dbp_data.vis_l_puk_kennzahl lkz
   ON lkz.kennzahl_id = kzs.kennzahl_id

   GROUP BY kzs.kennzahl_id, lkz.thema_id;