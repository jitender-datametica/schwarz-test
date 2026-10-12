CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MONAT
-- 23.08.2018 AP0031942, Umsatzplanung, Erweiterung der Einschränkung auf 3 Jahre in die Zukunft
-- 01.04.2020 NSR0505888, srom0404, telefonische Anforderung Fachbereich, anpassen akt_kj BETWEEN -3 AND 3 (vorher BETWEEN -2 AND 3)
-- 10.02.2021 SPEC0097989 richternic, VVJ Felder mit aufnehmen
(
  kjmo
, kjmo_vj
, kjmo_vvj
, kj
, mo_kj
, gj
, mo_gj

, akt_mo
, akt_mo_komplett
, akt_gj
, akt_gj_komplett
, akt_kj
, akt_kj_komplett

, gjmo
, gjmo_vj
, kjqu
, akt_kjqu
, akt_kjqu_komplett
, gjqu
, akt_gjqu
, akt_gjqu_komplett
, kjmo_vm
, kjmo_vm2

, mo_dat_von
, mo_dat_bis
)
AS
SELECT V01.KJMO ,
       V01.KJMO_VJ ,
       V01.KJMO_VVJ ,
       V01.KJ ,
       V01.MO_KJ ,
       V01.GJ ,
       V01.MO_GJ ,
       V01.AKT_MO ,
       V01.AKT_MO_KOMPLETT ,
       V01.AKT_GJ ,
       V01.AKT_GJ_KOMPLETT ,
       V01.AKT_KJ ,
       V01.AKT_KJ_KOMPLETT ,
       V01.GJMO ,
       V01.GJMO_VJ ,
       V01.KJQU ,
       V01.AKT_KJQU ,
       V01.AKT_KJQU_KOMPLETT ,
       V01.GJQU ,
       V01.AKT_GJQU ,
       V01.AKT_GJQU_KOMPLETT ,
       to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),-1),'YYYYMM')) AS KJMO_VM ,
       to_number(to_varchar(add_months(to_date(to_char(kjmo),'YYYYMM'),-2),'YYYYMM')) AS KJMO_VM2 ,
       V01.MIN_DAT AS MO_DAT_VON ,
       V01.MAX_DAT AS MO_DAT_BIS
FROM DBP_VIEW.V_MONAT V01
WHERE V01.AKT_KJ BETWEEN -3 AND 3;