CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_DISPO_GROUP_2
AS
   select
           ref_c.country_id             as client_id,
   ref_c.country_iso_cd        as country_iso_cd,
   dispogrp.dispo_group_id     as dispo_group_nr,
   dispogrp.language_id        as language_id,
   dispogrp.dispo_group_desc    as description
   from p_lew_core_ac.v_wawi_ref_country_2     ref_c
   join p_lew_core_ac.v_wawi_ref_itm_dispo_group_2 dispogrp
   ON dispogrp.client_id = ref_c.country_id
   JOIN p_lew_core_ac.v_client_migration_per_2 AS mig
   ON mig.client_id = dispogrp.client_id
   where CURRENT_DATE BETWEEN dispogrp.dat_rec_start  AND dispogrp.dat_rec_end
   /*Dispogruppen_2 kleiner 0 sind momentan lediglich Dummy_2-Gruppen - 20151009 AK*/
   and
   dispogrp.dispo_group_id > 0
;