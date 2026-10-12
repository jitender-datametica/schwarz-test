CREATE OR REPLACE VIEW dbp_msi_view_log.MV_L_NACHSCHUB_OPTION_1
-- 2021-05-10, dknop, SPEC0107644, AP0081632, initial

AS
SELECT 
v01.nachschub_option_id
from   dbp_view.v_l_nachschub_option_1 v01;