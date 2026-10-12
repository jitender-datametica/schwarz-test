create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_KREIS_ZU_PER_1(
	MANDANT_ID,
	MITARBEITER_KREIS_ID,
	MITARBEITER_ID,
	DAT_VON,
	DAT_BIS,
	KJMO,
	KJMO_VON,
	KJMO_BIS
) as
   SELECT V01.MANDANT_ID ,
       V01.MITARBEITER_KREIS_ID ,
       V01.MITARBEITER_ID ,
       V01.DAT_VON ,
       V01.DAT_BIS ,
       V01.KJMO ,
       CAST(EXTRACT(YEAR FROM V01.DAT_VON) || CASE
                                               WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_VON)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                               ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                         END AS INTEGER) AS KJMO_VON ,
       CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE
                                               WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                               ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                         END AS INTEGER) AS KJMO_BIS
FROM DBP_VIEW.V_MA_KREIS_ZU_PER_1 V01
JOIN DBP_VIEW.V_MONAT_1 V02 ON V02.KJMO 
BETWEEN CAST(EXTRACT(YEAR FROM V01.DAT_VON) || CASE
                                               WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_VON)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                               ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_VON))
                                         END AS INTEGER) 
    AND CAST(EXTRACT(YEAR FROM V01.DAT_BIS) || CASE
                                               WHEN TRIM(EXTRACT(MONTH FROM V01.DAT_BIS)) < 10 THEN '0' || TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                               ELSE TRIM(EXTRACT(MONTH FROM V01.DAT_BIS))
                                         END AS INTEGER)
AND V02.KJMO = V01.KJMO;