CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_GF
(
	GF_ID,
	MANDANT_ID,
	MA_LDAP,
	GF_NAME,
	GF_NAME_CZ,
	GF_NAME_SK,
	GF_NAME_HR,
	GF_NAME_PL,
	GF_NAME_RO,
	GF_NAME_BG
) AS
--15.06.2023 snik: SPEC0200542 Lookup GF, analog KMR
--07.09.2023 twie: SPEC0215747 ldap für Securityfilter GF hinzu

   SELECT
     ma_id AS gf_id
   , mandant_id
   , MAX(ma_ldap)
   , MAX(CASE WHEN spr_id = 22 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END)						AS gf_name
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_cz
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_sk
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_hr
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_pl
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_ro
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), gf_name)	AS gf_name_bg

   FROM
   (
    SELECT 
     mandant_id
	 , ma_id
	 , ma_name
	 , ma_vorname
	 , ma_anrede
	 , spr_id
	 , ma_ldap
    FROM dbp_view.v_ma_spr_zu
    WHERE (mandant_id, ma_id) IN 
    (
     SELECT mandant_id, gf_id
     FROM dbp_view.v_wup
     WHERE nb_id IN (0, -1, 2, 7)
     UNION ALL -- Zentralfilialen
     SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER
     FROM dbp_view.v_vs
    )
   ) msz
   GROUP BY 1, 2;