CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_HGA_MACHINE_HIST
AS 
SELECT
 core.t_dim_hga_hist.hga_sid
,core.t_dim_hga_hist.store_sid           
,core.t_dim_hga_hist.country_pol_cd
,core.t_dim_hga_hist.lob_cd                         
,core.t_dim_hga_hist.manufacturer_sid       
,core.t_dim_hga_hist.serial_nr              
,core.t_dim_hga_hist.store_nr            
,core.t_dim_hga_hist.store_name             
FROM 
CORE.T_DIM_HGA_HIST
WHERE 
dwh_valid_fg = True
;