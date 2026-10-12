CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_MAT_KJWO_UPDATE

-- cbru1709 20200224 Änderung von Datum_bis zu Datum_von - 1 als Bezeichnug des Tages

AS

SELECT 

  v01.mandant_id

 , v01.kjmo

 , v01.kjwo_update

 , v01.kjmo -100 as kjmo_vj

 , v02.kjwo_vj as kjwo_update_vj

 , 'MAT ' || trim(mo_bez) || ' ' || substr(cast(v01.kjmo as char(6)),1,4) || ' / KL data status ' || to_char(v02.wo_dat_von - 1,'DD.MM.YYYY') as kjwo_update_bez 

FROM dbp_view.v_l_kjmo_sort v01

 JOIN dbp_view.v_woche  v02

  ON (v01.kjwo_update = v02.kjwo)

 JOIN dbp_view.v_monat_spr_zu v03

  ON (cast(substr(cast(v01.kjmo as char(6)),5,2) as byteint) = v03.mo_id AND v03.spr_id = 24);