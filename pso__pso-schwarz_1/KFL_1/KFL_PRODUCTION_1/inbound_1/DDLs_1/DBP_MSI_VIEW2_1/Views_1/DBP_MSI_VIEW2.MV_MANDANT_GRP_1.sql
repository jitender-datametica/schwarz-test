CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_MANDANT_GRP_1 (mandantgrp_id,mandant_grp_bez)
AS
   SELECT  mandantgrp_id, mandant_grp_bez from dbp_view.v_mandant_grp_1;