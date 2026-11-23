; HEADER_BLOCK_START
; BambuStudio 02.06.01.55
; model printing time: 15m 23s; total estimated time: 15m 42s
; total layer number: 22
; total filament length [mm] : 2198.01
; total filament volume [cm^3] : 5286.84
; total filament weight [g] : 6.77
; filament_density: 1.28
; filament_diameter: 1.75
; max_z_height: 4.40
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; additional_fan_full_speed_layer = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 0x0,18x0,18x28,0x28
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = M620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nG1 X70 F21000\nG1 Y245\nG1 Y265 F3000\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 X120 F15000\n\nG1 X20 Y50 F21000\nG1 Y-3\n{if toolchange_count == 2}\n; get travel path for change filament\nM620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\nM620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\nM620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\nM620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}\nT[next_extruder]\nM620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}\n\n{if next_extruder < 255}\nM400\n\nG92 E0\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM109 S[nozzle_temperature_range_high]\n{if flush_length_1 > 23.7}\nG1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}\n{else}\nG1 E{flush_length_1} F{old_filament_e_feedrate}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 1}\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 1}\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_4 > 1}\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n; FLUSH_START\nM400\nM109 S[new_filament_temp]\nG1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature\n; FLUSH_END\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM106 P1 S255\nM400 S3\nG1 X80 F15000\nG1 X60 F15000\nG1 X80 F15000\nG1 X60 F15000; shake to put down garbage\n\nG1 X70 F5000\nG1 X90 F3000\nG1 Y255 F4000\nG1 X100 F5000\nG1 Y265 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X70 F10000\nG1 X100 F5000\nG1 X165 F15000; wipe and shake\nG1 Y256 ; move Y to aside, prevent collision\nM400\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 3
; close_fan_the_first_x_layers = 3
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 10000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL P1S 0.4 nozzle"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL X1C
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = ;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 1
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 
; extruder_clearance_dist_to_rod = 33
; extruder_clearance_height_to_lid = 90
; extruder_clearance_height_to_rod = 34
; extruder_clearance_max_radius = 68
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = 
; extruder_offset = 0x2
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 20
; fan_direction = left
; fan_max_speed = 40
; fan_min_speed = 20
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 300
; filament_bridge_speed = 25
; filament_change_length = 12
; filament_change_length_nc = 10
; filament_colour = #00AE42
; filament_cooling_before_tower = 0
; filament_cost = 24.99
; filament_density = 1.28
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 75
; filament_dev_ams_drying_temperature = 65
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 80
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 55
; filament_dev_drying_softening_temperature = 60
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG02
; filament_is_mixed = 0
; filament_is_support = 0
; filament_long_retractions_when_cut = 1
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 21
; filament_metal_stickiness = High
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 0
; filament_prime_volume = 30
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_retraction_distances_when_cut = 18
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Bambu PETG HF @BBL P1S 0.4 nozzle"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PETG
; filament_velocity_adaptation_factor = 1
; filament_vendor = "Bambu Lab"
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_volumes_matrix = 0,280,280,280,280,0,280,280,280,280,0,280,280,280,280,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.3
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.2
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10.6
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_end_gcode = ;===== date: 20230428 =====================\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nG1 Z{max_layer_z + 0.5} F900 ; lower z a little\nG1 X65 Y245 F12000 ; move to safe pos \nG1 Y265 F3000\n\nG1 X65 Y245 F12000\nG1 Y265 F3000\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\nG1 X100 F12000 ; wipe\n; pull back filament to AMS\nM620 S255\nG1 X20 Y50 F12000\nG1 Y-3\nT255\nG1 X65 F12000\nG1 Y265\nG1 X100 F12000 ; wipe\nM621 S255\nM104 S0 ; turn off hotend\n\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S3 ;wait for last picture to be taken\nM623; end of \"timelapse_record_flag\"\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 250}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z250 F600\n    G1 Z248\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X128 Y250 F3600\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 29
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,500
; machine_max_speed_y = 500,500
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = G0 Z20 F9000\nG92 E0; G1 E-10 F1200\nG28\nM970 Q1 A10 B10 C130 K0\nM970 Q1 A10 B131 C250 K1\nM974 Q1 S1 P0\nM970 Q0 A10 B10 C130 H20 K0\nM970 Q0 A10 B131 C250 K1\nM974 Q0 S1 P0\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nG29 ;Home\nG90;\nG92 E0 ;Reset Extruder \nG1 Z2.0 F3000 ;Move Z Axis up \nG1 X10.1 Y20 Z0.28 F5000.0 ;Move to start position\nM109 S205;\nG1 X10.1 Y200.0 Z0.28 F1500.0 E15 ;Draw the first line\nG1 X10.4 Y200.0 Z0.28 F5000.0 ;Move to side a little\nG1 X10.4 Y20 Z0.28 F1500.0 E30 ;Draw the second line\nG92 E0 ;Reset Extruder \nG1 X110 Y110 Z2.0 F3000 ;Move Z Axis up
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 28
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 245
; nozzle_temperature_initial_layer = 230
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 230
; nozzle_type = stainless_steel
; nozzle_volume = 107
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab P1S 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL X1C
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 250
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab P1S
; printer_notes = 
; printer_settings_id = Bambu Lab P1S 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 10
; slow_down_min_speed = 20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 150
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;========Date 20250206========\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\nM971 S11 C10 O0\n{elsif timelapse_type == 1} ; timelapse with wipe tower\nG92 E0\nG1 X65 Y245 F20000 ; move to safe pos\nG17\nG2 Z{layer_z} I0.86 J0.86 P1 F20000\nG1 Y265 F3000\nM400 P300\nM971 S11 C10 O0\nG92 E0\nG1 X100 F5000\nG1 Y255 F20000\n{endif}\nM623\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 500
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 220
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R15
M201 X20000 Y20000 Z500 E5000
M203 X500 Y500 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
M190 S70 ; set bed temperature and wait for it to be reached
; FEATURE: Custom
G0 Z20 F9000
G92 E0; G1 E-10 F1200
G28
M970 Q1 A10 B10 C130 K0
M970 Q1 A10 B131 C250 K1
M974 Q1 S1 P0
M970 Q0 A10 B10 C130 H20 K0
M970 Q0 A10 B131 C250 K1
M974 Q0 S1 P0
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
G29 ;Home
G90;
G92 E0 ;Reset Extruder 
G1 Z2.0 F3000 ;Move Z Axis up 
G1 X10.1 Y20 Z0.28 F5000.0 ;Move to start position
M109 S205;
G1 X10.1 Y200.0 Z0.28 F1500.0 E15 ;Draw the first line
G1 X10.4 Y200.0 Z0.28 F5000.0 ;Move to side a little
G1 X10.4 Y20 Z0.28 F1500.0 E30 ;Draw the second line
G92 E0 ;Reset Extruder 
M73 P1 R15
G1 X110 Y110 Z2.0 F3000 ;Move Z Axis up
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/22
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
M204 S6000
G1 Z.4 F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
M73 P2 R15
G1 X126.233 Y121.954
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X126.299 Y121.841 E.00475
G3 X127.846 Y120.946 I1.701 J1.157 E.06673
G1 X128.154 Y120.946 E.01111
G3 X126.146 Y122.107 I-.154 J2.051 E.37759
G1 X126.203 Y122.006 E.00419
M204 S6000
G1 X126.628 Y122.182 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X126.678 Y122.099 E.00352
G3 X127.88 Y121.403 I1.322 J.899 E.05188
G1 X128.12 Y121.403 E.00864
G3 X126.559 Y122.306 I-.12 J1.594 E.29355
G1 X126.599 Y122.235 E.00295
; WIPE_START
G1 X126.678 Y122.099 E-.0598
G1 X126.826 Y121.911 E-.09089
G1 X127.002 Y121.748 E-.09095
G1 X127.199 Y121.613 E-.09094
G1 X127.415 Y121.51 E-.09094
G1 X127.644 Y121.439 E-.09092
G1 X127.88 Y121.403 E-.09093
G1 X128.12 Y121.403 E-.09095
G1 X128.285 Y121.428 E-.06368
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X135.899 Y121.964 Z.6 F30000
G1 X142.984 Y122.463 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X143.034 Y122.693 E.0085
G3 X140.846 Y120.946 I-2.034 J.304 E.35536
G1 X141.154 Y120.946 E.01111
G3 X142.966 Y122.394 I-.154 J2.051 E.08896
G1 X142.969 Y122.405 E.00044
M204 S6000
G1 X142.538 Y122.565 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X142.581 Y122.762 E.00726
G3 X140.88 Y121.403 I-1.581 J.236 E.27627
G1 X141.12 Y121.403 E.00864
G3 X142.522 Y122.508 I-.12 J1.594 E.06837
; WIPE_START
G1 X142.581 Y122.762 E-.09916
G1 X142.601 Y123 E-.09088
G1 X142.583 Y123.239 E-.09093
G1 X142.53 Y123.472 E-.09094
G1 X142.443 Y123.695 E-.09092
G1 X142.323 Y123.902 E-.09095
G1 X142.174 Y124.089 E-.09092
G1 X141.998 Y124.252 E-.09095
G1 X141.945 Y124.288 E-.02434
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X135.049 Y121.018 Z.6 F30000
G1 X118.857 Y113.343 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X133.357 Y113.343 E.52354
G1 X133.357 Y116.057 E.098
G1 X114.643 Y116.057 E.67569
G1 X114.643 Y102.343 E.49516
G1 X133.357 Y102.343 E.67569
G1 X133.357 Y105.057 E.098
G1 X118.857 Y105.057 E.52354
G1 X118.857 Y113.283 E.297
M204 S6000
G1 X118.4 Y113.8 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X132.9 Y113.8 E.52354
G1 X132.9 Y115.6 E.06499
G1 X115.1 Y115.6 E.64269
G1 X115.1 Y102.8 E.46216
G1 X132.9 Y102.8 E.64269
G1 X132.9 Y104.6 E.06499
G1 X118.4 Y104.6 E.52354
G1 X118.4 Y113.74 E.33001
; WIPE_START
G1 X120.4 Y113.748 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X113.867 Y109.802 Z.6 F30000
G1 X110.457 Y107.743 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X112.857 Y107.743 E.08665
G1 X112.857 Y110.657 E.10522
G1 X110.457 Y110.657 E.08665
G1 X110.457 Y113.057 E.08665
G1 X107.543 Y113.057 E.10522
G1 X107.543 Y110.657 E.08665
G1 X105.143 Y110.657 E.08665
G1 X105.143 Y107.743 E.10522
G1 X107.543 Y107.743 E.08665
G1 X107.543 Y105.343 E.08665
G1 X110.457 Y105.343 E.10522
G1 X110.457 Y107.683 E.08449
M204 S6000
G1 X110 Y108.2 F30000
; FEATURE: Outer wall
M73 P3 R15
G1 F3000
M204 S500
G1 X112.4 Y108.2 E.08665
G1 X112.4 Y110.2 E.07221
G1 X110 Y110.2 E.08665
G1 X110 Y112.6 E.08665
G1 X108 Y112.6 E.07221
G1 X108 Y110.2 E.08665
G1 X105.6 Y110.2 E.08665
G1 X105.6 Y108.2 E.07221
G1 X108 Y108.2 E.08665
G1 X108 Y105.8 E.08665
G1 X110 Y105.8 E.07221
G1 X110 Y108.14 E.08449
; WIPE_START
G1 X111.999 Y108.19 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X114.519 Y115.395 Z.6 F30000
G1 X116.945 Y122.334 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X116.966 Y122.394 E.00229
G3 X114.846 Y120.946 I-1.966 J.604 E.36647
G1 X115.154 Y120.946 E.01111
G3 X116.854 Y122.107 I-.154 J2.051 E.07785
G1 X116.923 Y122.278 E.00665
M204 S6000
G1 X116.519 Y122.501 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X116.528 Y122.529 E.00105
G3 X114.88 Y121.403 I-1.528 J.469 E.28491
G1 X115.12 Y121.403 E.00864
G3 X116.441 Y122.306 I-.12 J1.594 E.06052
G1 X116.497 Y122.445 E.00542
; WIPE_START
G1 X116.528 Y122.529 E-.03382
G1 X116.583 Y122.761 E-.0909
G1 X116.601 Y123 E-.09093
G1 X116.583 Y123.239 E-.09093
G1 X116.53 Y123.472 E-.09094
G1 X116.443 Y123.695 E-.09092
G1 X116.323 Y123.902 E-.09095
G1 X116.174 Y124.089 E-.09092
G1 X116.001 Y124.25 E-.08968
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X117.096 Y131.803 Z.6 F30000
G1 X118.857 Y143.943 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X133.357 Y143.943 E.52354
G1 X133.357 Y146.657 E.098
G1 X114.643 Y146.657 E.67569
G1 X114.643 Y132.943 E.49516
G1 X133.357 Y132.943 E.67569
G1 X133.357 Y135.657 E.098
G1 X118.857 Y135.657 E.52354
G1 X118.857 Y143.883 E.297
M204 S6000
G1 X118.4 Y144.4 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X132.9 Y144.4 E.52354
G1 X132.9 Y146.2 E.06499
G1 X115.1 Y146.2 E.64269
G1 X115.1 Y133.4 E.46216
G1 X132.9 Y133.4 E.64269
G1 X132.9 Y135.2 E.06499
G1 X118.4 Y135.2 E.52354
G1 X118.4 Y144.34 E.33001
; WIPE_START
G1 X120.4 Y144.348 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X113.328 Y141.479 Z.6 F30000
G1 X105.6 Y138.343 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X112.857 Y138.343 E.26202
G1 X112.857 Y141.257 E.10522
G1 X105.143 Y141.257 E.27853
G1 X105.143 Y138.343 E.10522
G1 X105.54 Y138.343 E.01434
M204 S6000
G1 X105.6 Y138.8 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X112.4 Y138.8 E.24552
G1 X112.4 Y140.8 E.07221
G1 X105.6 Y140.8 E.24552
G1 X105.6 Y138.86 E.07005
; WIPE_START
G1 X107.6 Y138.842 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X115.214 Y138.315 Z.6 F30000
G1 X119.143 Y138.043 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X119.143 Y141.557 E.12688
G1 X153.143 Y141.557 E1.2276
G1 X153.143 Y149.684 E.29343
M73 P4 R15
G3 X151.982 Y150.843 I-1.147 J.012 E.06599
G1 X104.016 Y150.843 E1.73186
G3 X102.857 Y149.683 I-.013 J-1.146 E.06598
G1 X102.857 Y102.316 E1.71022
G3 X104.018 Y101.157 I1.147 J-.012 E.06599
G1 X104.495 Y101.157 E.01724
G1 X151.991 Y101.157 E1.7149
G3 X153.143 Y102.316 I.006 J1.146 E.06567
G1 X153.143 Y107.443 E.18511
G1 X119.143 Y107.443 E1.2276
G1 X119.143 Y110.957 E.12688
G1 X153.143 Y110.957 E1.2276
G1 X153.143 Y138.043 E.97796
G1 X119.203 Y138.043 E1.22544
M204 S6000
M73 P4 R14
G1 X119.6 Y138.5 F30000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X119.6 Y141.1 E.09388
G1 X153.6 Y141.1 E1.2276
G1 X153.6 Y149.692 E.31024
G3 X151.992 Y151.3 I-1.604 J.004 E.09127
G1 X104.008 Y151.3 E1.73251
G3 X102.4 Y149.692 I-.004 J-1.603 E.09126
G1 X102.4 Y102.308 E1.71086
M73 P5 R14
G3 X104.008 Y100.7 I1.604 J-.004 E.09127
G1 X104.495 Y100.7 E.01757
G1 X152 Y100.7 E1.71521
G3 X153.6 Y102.308 I-.003 J1.603 E.09097
G1 X153.6 Y107.9 E.20192
G1 X119.6 Y107.9 E1.2276
G1 X119.6 Y110.5 E.09388
G1 X153.6 Y110.5 E1.2276
G1 X153.6 Y138.5 E1.01097
G1 X119.66 Y138.5 E1.22544
; WIPE_START
G1 X119.614 Y140.499 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X118.599 Y132.935 Z.6 F30000
G1 X114.414 Y101.75 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.771608
G1 F3000
M204 S500
G1 X133.586 Y101.75 E1.10351
; WIPE_START
G1 X131.586 Y101.75 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X139.216 Y101.601 Z.6 F30000
G1 X152.108 Y101.349 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5067
G1 F6300
M204 S500
G1 X152.569 Y101.809 E.02385
G3 X152.751 Y102.245 I-.573 J.495 E.01758
G1 X152.751 Y102.648 E.01476
G1 X151.649 Y101.546 E.05709
G1 X150.993 Y101.546 E.02403
G1 X152.752 Y103.304 E.0911
G1 X152.752 Y103.96 E.02405
G1 X150.337 Y101.546 E.1251
G1 X149.681 Y101.546 E.02403
G1 X152.753 Y104.617 E.15911
G1 X152.753 Y105.273 E.02405
G1 X149.026 Y101.546 E.19312
G1 X148.37 Y101.546 E.02403
G1 X152.753 Y105.929 E.22712
G1 X152.754 Y106.586 E.02405
G1 X147.714 Y101.546 E.26113
G1 X147.058 Y101.546 E.02403
G1 X152.567 Y107.055 E.28541
G1 X151.911 Y107.055 E.02403
G1 X146.402 Y101.546 E.28541
G1 X145.746 Y101.546 E.02403
G1 X151.255 Y107.055 E.28541
G1 X150.599 Y107.055 E.02403
G1 X145.09 Y101.546 E.28541
G1 X144.434 Y101.546 E.02403
G1 X149.943 Y107.055 E.28541
G1 X149.287 Y107.055 E.02403
G1 X143.779 Y101.546 E.28541
G1 X143.123 Y101.546 E.02403
G1 X148.631 Y107.055 E.28541
M73 P6 R14
G1 X147.976 Y107.055 E.02403
G1 X142.467 Y101.546 E.28541
G1 X141.811 Y101.546 E.02403
G1 X147.32 Y107.055 E.28541
G1 X146.664 Y107.055 E.02403
G1 X141.155 Y101.546 E.28541
G1 X140.499 Y101.546 E.02403
G1 X146.008 Y107.055 E.28541
G1 X145.352 Y107.055 E.02403
G1 X139.843 Y101.546 E.28541
G1 X139.187 Y101.546 E.02403
G1 X144.696 Y107.055 E.28541
G1 X144.04 Y107.055 E.02403
G1 X138.531 Y101.546 E.28541
G1 X137.876 Y101.546 E.02403
G1 X143.384 Y107.055 E.28541
G1 X142.728 Y107.055 E.02403
G1 X137.22 Y101.546 E.28541
G1 X136.564 Y101.546 E.02403
G1 X142.073 Y107.055 E.28541
G1 X141.417 Y107.055 E.02403
G1 X135.908 Y101.546 E.28541
G1 X135.252 Y101.546 E.02403
G1 X140.761 Y107.055 E.28542
G1 X140.105 Y107.055 E.02403
G1 X134.596 Y101.546 E.28542
G1 X133.974 Y101.546 E.02279
G1 X133.974 Y101.579 E.00124
G1 X139.449 Y107.055 E.28367
G1 X138.793 Y107.055 E.02403
G1 X133.974 Y102.235 E.24969
G1 X133.974 Y102.524 E.01059
G1 X133.745 Y102.524 E.00837
G1 X133.745 Y102.663 E.00507
G1 X138.137 Y107.055 E.22754
G1 X137.481 Y107.055 E.02403
G1 X133.745 Y103.319 E.19356
G1 X133.745 Y103.974 E.02403
G1 X136.826 Y107.055 E.15958
G1 X136.17 Y107.055 E.02403
G1 X133.745 Y104.63 E.1256
G1 X133.745 Y105.286 E.02403
G1 X135.514 Y107.055 E.09162
G1 X134.858 Y107.055 E.02403
G1 X133.249 Y105.445 E.08337
G1 X132.593 Y105.445 E.02403
G1 X134.202 Y107.055 E.08337
G1 X133.546 Y107.055 E.02403
G1 X131.937 Y105.445 E.08337
G1 X131.281 Y105.445 E.02403
G1 X132.89 Y107.055 E.08337
G1 X132.234 Y107.055 E.02403
G1 X130.625 Y105.445 E.08337
G1 X129.969 Y105.445 E.02403
G1 X131.578 Y107.055 E.08337
G1 X130.923 Y107.055 E.02403
G1 X129.314 Y105.445 E.08337
G1 X128.658 Y105.445 E.02403
G1 X130.267 Y107.055 E.08337
G1 X129.611 Y107.055 E.02403
G1 X128.002 Y105.445 E.08337
G1 X127.346 Y105.445 E.02403
G1 X128.955 Y107.055 E.08337
G1 X128.299 Y107.055 E.02403
G1 X126.69 Y105.445 E.08337
G1 X126.034 Y105.445 E.02403
G1 X127.643 Y107.055 E.08337
G1 X126.987 Y107.055 E.02403
G1 X125.378 Y105.445 E.08336
G1 X124.722 Y105.445 E.02403
G1 X126.331 Y107.055 E.08336
G1 X125.676 Y107.055 E.02403
G1 X124.066 Y105.445 E.08336
G1 X123.411 Y105.445 E.02403
G1 X125.02 Y107.055 E.08336
G1 X124.364 Y107.055 E.02403
G1 X122.755 Y105.445 E.08337
G1 X122.099 Y105.445 E.02403
G1 X123.708 Y107.055 E.08336
G1 X123.052 Y107.055 E.02403
G1 X121.443 Y105.445 E.08336
G1 X120.787 Y105.445 E.02403
G1 X122.396 Y107.055 E.08336
G1 X121.74 Y107.055 E.02403
G1 X120.131 Y105.445 E.08336
G1 X119.475 Y105.445 E.02403
G1 X121.084 Y107.055 E.08337
G1 X120.428 Y107.055 E.02403
G1 X119.245 Y105.872 E.06129
G1 X119.245 Y106.527 E.02403
G1 X119.978 Y107.26 E.03796
; WIPE_START
G1 X119.245 Y106.527 E-.39379
G1 X119.245 Y105.872 E-.24924
G1 X119.463 Y106.089 E-.11698
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X127.005 Y107.259 Z.6 F30000
G1 X152.032 Y111.14 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.50204
G1 F6300
M204 S500
G1 X152.755 Y111.862 E.03706
G1 X152.755 Y112.512 E.02355
G1 X151.588 Y111.345 E.05982
G1 X150.939 Y111.345 E.02355
G1 X152.755 Y113.161 E.09312
G1 X152.755 Y113.81 E.02355
G1 X150.29 Y111.345 E.12642
M73 P7 R14
G1 X149.64 Y111.345 E.02355
G1 X152.755 Y114.46 E.15972
G1 X152.755 Y115.109 E.02355
G1 X148.991 Y111.345 E.19302
G1 X148.342 Y111.345 E.02355
G1 X152.755 Y115.758 E.22633
G1 X152.755 Y116.407 E.02355
G1 X147.693 Y111.345 E.25963
G1 X147.043 Y111.345 E.02355
G1 X152.755 Y117.057 E.29293
G1 X152.755 Y117.706 E.02355
G1 X146.394 Y111.345 E.32623
G1 X145.745 Y111.345 E.02355
G1 X152.755 Y118.355 E.35953
G1 X152.755 Y119.005 E.02355
G1 X145.095 Y111.345 E.39284
G1 X144.446 Y111.345 E.02355
G1 X152.755 Y119.654 E.42614
G1 X152.755 Y120.303 E.02355
G1 X143.797 Y111.345 E.45944
G1 X143.147 Y111.345 E.02355
G1 X152.755 Y120.953 E.49274
G1 X152.755 Y121.602 E.02355
G1 X142.498 Y111.345 E.52604
G1 X141.849 Y111.345 E.02355
G1 X152.755 Y122.251 E.55935
G1 X152.755 Y122.9 E.02355
G1 X141.2 Y111.345 E.59265
G1 X140.55 Y111.345 E.02355
G1 X152.755 Y123.55 E.62595
G1 X152.755 Y124.199 E.02355
G1 X139.901 Y111.345 E.65925
G1 X139.252 Y111.345 E.02355
G1 X152.755 Y124.848 E.69255
G1 X152.755 Y125.498 E.02355
G1 X138.602 Y111.345 E.72586
G1 X137.953 Y111.345 E.02355
G1 X152.755 Y126.147 E.75916
G1 X152.755 Y126.796 E.02355
G1 X137.304 Y111.345 E.79246
G1 X136.655 Y111.345 E.02355
G1 X152.755 Y127.445 E.82576
G1 X152.755 Y128.095 E.02355
G1 X136.005 Y111.345 E.85906
G1 X135.356 Y111.345 E.02355
G1 X152.755 Y128.744 E.89237
G1 X152.755 Y129.393 E.02355
G1 X134.707 Y111.345 E.92567
G1 X134.057 Y111.345 E.02355
G1 X152.755 Y130.043 E.95897
G1 X152.755 Y130.692 E.02355
G1 X133.408 Y111.345 E.99227
G1 X132.759 Y111.345 E.02355
G1 X152.755 Y131.341 E1.02557
M73 P8 R14
G1 X152.755 Y131.991 E.02355
G1 X143.423 Y122.659 E.47859
G3 X143.426 Y123.311 I-2.16 J.333 E.02372
G1 X152.755 Y132.64 E.47847
G1 X152.755 Y133.289 E.02355
G1 X143.297 Y123.832 E.48507
G3 X143.086 Y124.27 I-1.561 J-.479 E.01771
G1 X152.755 Y133.938 E.49587
G1 X152.755 Y134.588 E.02355
G1 X142.812 Y124.645 E.50996
G1 X142.795 Y124.666 E.00096
G3 X142.471 Y124.953 I-1.115 J-.932 E.01578
G1 X152.755 Y135.237 E.52746
G1 X152.755 Y135.886 E.02355
G1 X142.066 Y125.197 E.54823
G3 X141.592 Y125.373 I-.82 J-1.483 E.01839
G1 X152.755 Y136.536 E.57252
G1 X152.755 Y137.185 E.02355
G1 X140.801 Y125.232 E.61307
; WIPE_START
G1 X142.216 Y126.646 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X141.613 Y120.849 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X132.109 Y111.345 E.48741
G1 X131.46 Y111.345 E.02355
G1 X133.069 Y112.955 E.08253
G1 X132.42 Y112.955 E.02355
G1 X130.811 Y111.345 E.08253
G1 X130.162 Y111.345 E.02355
G1 X131.771 Y112.955 E.08253
G1 X131.121 Y112.955 E.02355
G1 X129.512 Y111.345 E.08253
G1 X128.863 Y111.345 E.02355
G1 X130.472 Y112.955 E.08253
G1 X129.823 Y112.955 E.02355
G1 X128.214 Y111.345 E.08253
G1 X127.564 Y111.345 E.02355
G1 X129.173 Y112.955 E.08253
G1 X128.524 Y112.955 E.02355
G1 X126.915 Y111.345 E.08253
G1 X126.266 Y111.345 E.02355
G1 X127.875 Y112.955 E.08253
G1 X127.226 Y112.955 E.02355
G1 X125.617 Y111.345 E.08253
G1 X124.967 Y111.345 E.02355
G1 X126.576 Y112.955 E.08253
G1 X125.927 Y112.955 E.02355
G1 X124.318 Y111.345 E.08253
G1 X123.669 Y111.345 E.02355
G1 X125.278 Y112.955 E.08253
G1 X124.628 Y112.955 E.02355
G1 X123.019 Y111.345 E.08253
G1 X122.37 Y111.345 E.02355
G1 X123.979 Y112.955 E.08253
G1 X123.33 Y112.955 E.02355
G1 X121.721 Y111.345 E.08253
G1 X121.071 Y111.345 E.02355
G1 X122.681 Y112.955 E.08253
G1 X122.031 Y112.955 E.02355
G1 X120.422 Y111.345 E.08253
G1 X119.773 Y111.345 E.02355
G1 X121.382 Y112.955 E.08253
G1 X120.733 Y112.955 E.02355
G1 X119.245 Y111.467 E.07628
G1 X119.245 Y112.117 E.02355
G1 X120.083 Y112.955 E.04297
G1 X119.434 Y112.955 E.02355
G1 X119.04 Y112.56 E.02022
; WIPE_START
G1 X119.434 Y112.955 E-.21187
G1 X120.083 Y112.955 E-.24673
G1 X119.523 Y112.394 E-.30139
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X127.134 Y112.954 Z.6 F30000
G1 X133.54 Y113.425 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X140.692 Y120.577 E.36681
G2 X140.167 Y120.701 I.151 J1.803 E.01963
G1 X133.745 Y114.28 E.32935
G1 X133.745 Y114.929 E.02355
G1 X139.728 Y120.912 E.30683
G2 X139.358 Y121.192 I.742 J1.363 E.01687
G1 X133.745 Y115.579 E.28789
G1 X133.745 Y116.228 E.02355
G1 X139.048 Y121.531 E.27197
G2 X138.798 Y121.93 I1.2 J1.03 E.01715
G1 X133.314 Y116.445 E.28129
G1 X132.664 Y116.445 E.02355
G1 X138.63 Y122.411 E.30595
M73 P9 R14
G2 X138.552 Y122.983 I1.859 J.542 E.02101
G1 X132.015 Y116.445 E.33529
G1 X131.366 Y116.445 E.02355
G1 X138.671 Y123.751 E.37469
G2 X140.242 Y125.322 I2.341 J-.77 E.08359
G1 X152.575 Y137.655 E.63253
G1 X151.926 Y137.655 E.02355
G1 X130.717 Y116.445 E1.0878
G1 X130.067 Y116.445 E.02355
G1 X151.276 Y137.655 E1.0878
G1 X150.627 Y137.655 E.02355
G1 X129.418 Y116.445 E1.0878
G1 X128.769 Y116.445 E.02355
G1 X149.978 Y137.655 E1.0878
G1 X149.328 Y137.655 E.02355
G1 X128.119 Y116.445 E1.0878
G1 X127.47 Y116.445 E.02355
G1 X148.679 Y137.655 E1.0878
G1 X148.03 Y137.655 E.02355
G1 X126.821 Y116.445 E1.0878
G1 X126.171 Y116.445 E.02355
G1 X147.381 Y137.655 E1.0878
G1 X146.731 Y137.655 E.02355
G1 X125.522 Y116.445 E1.0878
G1 X124.873 Y116.445 E.02355
G1 X146.082 Y137.655 E1.0878
G1 X145.433 Y137.655 E.02355
G1 X130.422 Y122.644 E.76987
G3 X130.427 Y123.298 I-2.167 J.341 E.02379
G1 X144.783 Y137.655 E.73635
G1 X144.134 Y137.655 E.02355
G1 X130.301 Y123.822 E.70949
G3 X130.092 Y124.261 I-1.564 J-.475 E.01773
G1 X143.485 Y137.655 E.68693
G1 X142.835 Y137.655 E.02355
G1 X129.818 Y124.637 E.66766
G1 X129.795 Y124.666 E.00133
G3 X129.479 Y124.947 I-1.091 J-.906 E.01542
G1 X142.186 Y137.655 E.65174
G1 X141.537 Y137.655 E.02355
G1 X129.075 Y125.193 E.63916
G3 X128.603 Y125.37 I-.823 J-1.479 E.01836
G1 X140.888 Y137.655 E.63008
G1 X140.238 Y137.655 E.02355
G1 X127.818 Y125.234 E.63703
; WIPE_START
M73 P10 R14
G1 X129.232 Y126.648 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X128.633 Y120.855 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X124.224 Y116.445 E.22615
G1 X123.574 Y116.445 E.02355
G1 X127.704 Y120.575 E.2118
G2 X127.178 Y120.698 I.145 J1.807 E.01967
G1 X122.925 Y116.445 E.21811
G1 X122.276 Y116.445 E.02355
G1 X126.736 Y120.906 E.22878
G2 X126.366 Y121.185 I.739 J1.366 E.01688
G1 X121.626 Y116.445 E.24308
G1 X120.977 Y116.445 E.02355
G1 X126.054 Y121.523 E.26041
G2 X125.803 Y121.921 I1.195 J1.033 E.01713
G1 X120.328 Y116.445 E.28083
G1 X119.679 Y116.445 E.02355
G1 X125.632 Y122.399 E.30536
G2 X125.553 Y122.97 I1.853 J.547 E.02096
G1 X119.029 Y116.445 E.33462
G1 X118.38 Y116.445 E.02355
G1 X125.662 Y123.728 E.3735
G2 X127.263 Y125.328 I2.352 J-.751 E.08528
G1 X139.589 Y137.655 E.63221
G1 X138.94 Y137.655 E.02355
G1 X117.731 Y116.445 E1.0878
G1 X117.081 Y116.445 E.02355
G1 X133.19 Y132.555 E.82623
G1 X133.745 Y132.555 E.02013
G1 X133.745 Y133.11 E.02013
G1 X138.29 Y137.655 E.23311
G1 X137.641 Y137.655 E.02355
G1 X133.745 Y133.759 E.19981
G1 X133.745 Y134.408 E.02355
G1 X136.992 Y137.655 E.1665
G1 X136.343 Y137.655 E.02355
G1 X133.745 Y135.057 E.1332
G1 X133.745 Y135.707 E.02355
G1 X135.693 Y137.655 E.0999
G1 X135.044 Y137.655 E.02355
G1 X133.435 Y136.045 E.08253
G1 X132.786 Y136.045 E.02355
G1 X134.395 Y137.655 E.08253
G1 X133.745 Y137.655 E.02355
G1 X132.136 Y136.045 E.08253
G1 X131.487 Y136.045 E.02355
G1 X133.096 Y137.655 E.08253
G1 X132.447 Y137.655 E.02355
G1 X130.838 Y136.045 E.08253
G1 X130.188 Y136.045 E.02355
G1 X131.797 Y137.655 E.08253
G1 X131.148 Y137.655 E.02355
G1 X129.539 Y136.045 E.08253
G1 X128.89 Y136.045 E.02355
G1 X130.499 Y137.655 E.08253
G1 X129.85 Y137.655 E.02355
G1 X128.241 Y136.045 E.08253
G1 X127.591 Y136.045 E.02355
G1 X129.2 Y137.655 E.08253
G1 X128.551 Y137.655 E.02355
G1 X126.942 Y136.045 E.08253
G1 X126.293 Y136.045 E.02355
G1 X127.902 Y137.655 E.08253
G1 X127.252 Y137.655 E.02355
G1 X125.643 Y136.045 E.08253
G1 X124.994 Y136.045 E.02355
G1 X126.603 Y137.655 E.08253
G1 X125.954 Y137.655 E.02355
G1 X124.345 Y136.045 E.08253
G1 X123.695 Y136.045 E.02355
G1 X125.305 Y137.655 E.08253
G1 X124.655 Y137.655 E.02355
G1 X123.046 Y136.045 E.08253
G1 X122.397 Y136.045 E.02355
G1 X124.006 Y137.655 E.08253
G1 X123.357 Y137.655 E.02355
G1 X121.748 Y136.045 E.08253
G1 X121.098 Y136.045 E.02355
G1 X122.707 Y137.655 E.08253
G1 X122.058 Y137.655 E.02355
G1 X120.449 Y136.045 E.08253
G1 X119.8 Y136.045 E.02355
G1 X121.409 Y137.655 E.08253
G1 X120.759 Y137.655 E.02355
G1 X119.245 Y136.141 E.07765
G1 X119.245 Y136.79 E.02355
G1 X120.11 Y137.655 E.04435
G1 X119.461 Y137.655 E.02355
M73 P10 R13
G1 X119.04 Y137.233 E.0216
; WIPE_START
G1 X119.461 Y137.655 E-.2263
G1 X120.11 Y137.655 E-.24673
G1 X119.576 Y137.121 E-.28697
; WIPE_END
G1 E-.04 F1800
M204 S6000
M73 P11 R13
G1 X126.822 Y134.722 Z.6 F30000
G1 X132.747 Y132.76 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X116.432 Y116.445 E.83678
G1 X115.783 Y116.445 E.02355
G1 X131.892 Y132.555 E.82623
G1 X131.243 Y132.555 E.02355
G1 X114.928 Y116.24 E.83678
; WIPE_START
G1 X116.342 Y117.654 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X110.121 Y113.232 Z.6 F30000
G1 X107.36 Y111.269 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X107.136 Y111.045 E.01148
G1 X106.487 Y111.045 E.02355
G1 X107.155 Y111.713 E.03424
G1 X107.155 Y112.362 E.02355
G1 X105.632 Y110.84 E.07809
; WIPE_START
G1 X107.046 Y112.254 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X111.003 Y105.727 Z.6 F30000
G1 X113.663 Y101.34 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X114.232 Y101.909 E.02917
M204 S6000
G1 X114.46 Y102.786 F30000
G1 F6300
M204 S500
G1 X113.219 Y101.546 E.06364
G1 X112.57 Y101.546 E.02355
G1 X114.255 Y103.23 E.08639
G1 X114.255 Y103.879 E.02355
G1 X111.921 Y101.546 E.11969
G1 X111.272 Y101.546 E.02355
G1 X114.255 Y104.529 E.153
G1 X114.255 Y105.178 E.02355
G1 X110.622 Y101.546 E.1863
G1 X109.973 Y101.546 E.02355
G1 X114.255 Y105.827 E.2196
G1 X114.255 Y106.476 E.02355
G1 X109.324 Y101.546 E.2529
G1 X108.674 Y101.545 E.02355
G1 X114.255 Y107.126 E.28621
G1 X114.255 Y107.775 E.02355
G1 X108.025 Y101.545 E.31951
G1 X107.376 Y101.545 E.02355
G1 X114.255 Y108.424 E.35281
G1 X114.255 Y109.074 E.02355
G1 X113.245 Y108.065 E.05175
G1 X113.245 Y108.714 E.02355
G1 X114.255 Y109.723 E.05175
G1 X114.255 Y110.372 E.02355
G1 X113.245 Y109.363 E.05175
G1 X113.245 Y110.012 E.02355
G1 X114.255 Y111.021 E.05175
G1 X114.255 Y111.671 E.02355
G1 X113.245 Y110.662 E.05175
G1 X113.245 Y111.045 E.01392
G1 X112.98 Y111.045 E.00963
G1 X114.255 Y112.32 E.06537
G1 X114.255 Y112.969 E.02355
G1 X112.331 Y111.045 E.09867
G1 X111.681 Y111.045 E.02355
G1 X114.255 Y113.619 E.13198
G1 X114.255 Y114.268 E.02355
G1 X111.032 Y111.045 E.16528
G1 X110.845 Y111.045 E.00677
G1 X110.845 Y111.508 E.01678
G1 X114.255 Y114.917 E.17485
G1 X114.255 Y115.567 E.02355
G1 X110.845 Y112.157 E.17485
G1 X110.845 Y112.807 E.02355
G1 X130.593 Y132.555 E1.01285
G1 X129.944 Y132.555 E.02355
G1 X110.835 Y113.445 E.9801
G1 X110.186 Y113.445 E.02355
G1 X129.295 Y132.555 E.9801
G1 X128.645 Y132.555 E.02355
G1 X109.536 Y113.445 E.98009
G1 X108.887 Y113.445 E.02355
G1 X127.996 Y132.555 E.98009
G1 X127.347 Y132.555 E.02355
G1 X117.422 Y122.635 E.50891
G3 X117.428 Y123.285 I-2.152 J.345 E.02365
G1 X126.697 Y132.555 E.47545
G1 X126.048 Y132.555 E.02355
G1 X117.305 Y123.811 E.44843
M73 P12 R13
G3 X117.097 Y124.252 I-1.568 J-.471 E.01776
G1 X125.399 Y132.555 E.42581
G1 X124.75 Y132.555 E.02355
G1 X116.824 Y124.629 E.40648
G1 X116.487 Y124.942 E.01666
G1 X124.1 Y132.555 E.39046
G1 X123.451 Y132.555 E.02355
G1 X116.085 Y125.188 E.37782
G3 X115.614 Y125.366 I-.826 J-1.473 E.01834
G1 X122.802 Y132.555 E.36868
G1 X122.152 Y132.555 E.02355
G1 X114.834 Y125.236 E.37534
; WIPE_START
G1 X116.249 Y126.651 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X115.653 Y120.861 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X108.032 Y113.24 E.3909
; WIPE_START
G1 X109.446 Y114.654 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X112.661 Y107.732 Z.6 F30000
G1 X112.741 Y107.56 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X110.845 Y105.665 E.09723
G1 X110.845 Y106.314 E.02355
G1 X111.886 Y107.355 E.05338
G1 X111.237 Y107.355 E.02355
G1 X110.64 Y106.757 E.03062
; WIPE_START
G1 X111.237 Y107.355 E-.32087
G1 X111.886 Y107.355 E-.24674
G1 X111.528 Y106.997 E-.19239
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X110.341 Y105.16 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X106.726 Y101.545 E.1854
G1 X106.077 Y101.545 E.02355
G1 X109.486 Y104.955 E.17485
G1 X108.837 Y104.955 E.02355
G1 X105.428 Y101.545 E.17485
G1 X104.779 Y101.545 E.02355
G1 X108.188 Y104.955 E.17485
G1 X107.538 Y104.955 E.02355
G1 X104.136 Y101.553 E.17448
G2 X103.601 Y101.666 I-.097 J.865 E.02021
G1 X107.155 Y105.22 E.18228
G1 X107.155 Y105.869 E.02355
G1 X103.307 Y102.022 E.19735
G2 X103.245 Y102.61 I1.406 J.444 E.02159
G1 X107.155 Y106.519 E.20049
G1 X107.155 Y107.168 E.02355
G1 X103.245 Y103.259 E.20049
G1 X103.245 Y103.908 E.02355
G1 X106.692 Y107.355 E.17676
G1 X106.043 Y107.355 E.02355
G1 X103.245 Y104.557 E.14346
G1 X103.245 Y105.207 E.02355
G1 X105.393 Y107.355 E.11016
G1 X104.755 Y107.365 E.02317
G1 X103.245 Y105.856 E.0774
G1 X103.245 Y106.505 E.02355
G1 X104.755 Y108.014 E.0774
G1 X104.755 Y108.664 E.02355
G1 X103.245 Y107.155 E.0774
G1 X103.245 Y107.804 E.02355
G1 X104.755 Y109.313 E.0774
G1 X104.755 Y109.962 E.02355
G1 X103.245 Y108.453 E.0774
G1 X103.245 Y109.103 E.02355
G1 X104.755 Y110.612 E.0774
G1 X104.755 Y111.045 E.01574
G1 X105.188 Y111.045 E.01574
G1 X107.155 Y113.012 E.10084
G1 X107.155 Y113.445 E.01574
G1 X107.588 Y113.445 E.01574
G1 X114.716 Y120.573 E.36557
G2 X114.188 Y120.695 I.14 J1.812 E.01971
G1 X103.245 Y109.752 E.56126
G1 X103.245 Y110.401 E.02355
G1 X113.745 Y120.9 E.53849
G2 X113.373 Y121.178 I.734 J1.369 E.01689
G1 X103.245 Y111.05 E.51944
G1 X103.245 Y111.7 E.02355
G1 X113.061 Y121.515 E.50342
G2 X112.808 Y121.912 I1.191 J1.036 E.01712
G1 X103.245 Y112.349 E.49048
G1 X103.245 Y112.998 E.02355
G1 X112.635 Y122.388 E.48158
G2 X112.554 Y122.956 I1.846 J.551 E.02091
G1 X103.245 Y113.648 E.47744
M73 P13 R13
G1 X103.245 Y114.297 E.02355
G1 X112.66 Y123.722 E.48313
G2 X114.283 Y125.335 I2.354 J-.746 E.08628
G1 X121.503 Y132.555 E.37031
G1 X120.854 Y132.555 E.02355
G1 X103.245 Y114.946 E.90312
G1 X103.245 Y115.595 E.02355
G1 X120.205 Y132.555 E.86982
G1 X119.555 Y132.555 E.02355
G1 X103.245 Y116.245 E.83652
G1 X103.245 Y116.894 E.02355
G1 X118.906 Y132.555 E.80322
G1 X118.257 Y132.555 E.02355
G1 X103.245 Y117.543 E.76992
G1 X103.245 Y118.193 E.02355
G1 X117.607 Y132.555 E.73661
G1 X116.958 Y132.555 E.02355
G1 X103.245 Y118.842 E.70331
G1 X103.245 Y119.491 E.02355
G1 X116.309 Y132.555 E.67001
G1 X115.659 Y132.555 E.02355
G1 X103.245 Y120.141 E.63671
G1 X103.245 Y120.79 E.02355
G1 X115.01 Y132.555 E.60341
G1 X114.361 Y132.555 E.02355
G1 X103.245 Y121.439 E.57011
G1 X103.245 Y122.088 E.02355
G1 X114.255 Y133.097 E.56465
G1 X114.255 Y133.747 E.02355
G1 X103.245 Y122.738 E.56465
G1 X103.245 Y123.387 E.02355
G1 X114.255 Y134.396 E.56465
G1 X114.255 Y135.045 E.02355
G1 X103.245 Y124.036 E.56465
G1 X103.245 Y124.686 E.02355
G1 X114.255 Y135.695 E.56465
G1 X114.255 Y136.344 E.02355
G1 X103.245 Y125.335 E.56465
G1 X103.245 Y125.984 E.02355
G1 X114.255 Y136.993 E.56465
G1 X114.255 Y137.642 E.02355
G1 X103.245 Y126.633 E.56465
G1 X103.245 Y127.283 E.02355
G1 X114.255 Y138.292 E.56465
G1 X114.255 Y138.941 E.02355
G1 X103.245 Y127.932 E.56465
G1 X103.245 Y128.581 E.02355
G1 X112.619 Y137.955 E.48075
G1 X113.245 Y137.955 E.02273
G1 X113.245 Y138.581 E.02273
M73 P14 R13
G1 X114.255 Y139.59 E.05175
G1 X114.255 Y140.24 E.02355
G1 X113.245 Y139.231 E.05175
G1 X113.245 Y139.88 E.02355
G1 X114.255 Y140.889 E.05175
G1 X114.255 Y141.538 E.02355
G1 X113.245 Y140.529 E.05175
G1 X113.245 Y141.179 E.02355
G1 X114.255 Y142.188 E.05175
G1 X114.255 Y142.837 E.02355
G1 X113.063 Y141.645 E.0611
G1 X112.414 Y141.645 E.02355
G1 X114.255 Y143.486 E.09441
G1 X114.255 Y144.135 E.02355
G1 X111.765 Y141.645 E.12771
G1 X111.115 Y141.645 E.02355
G1 X114.255 Y144.785 E.16101
G1 X114.255 Y145.434 E.02355
G1 X110.466 Y141.645 E.19431
G1 X109.817 Y141.645 E.02355
G1 X114.46 Y146.289 E.23816
; WIPE_START
G1 X113.046 Y144.875 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X112.175 Y138.16 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X103.245 Y129.231 E.45799
G1 X103.245 Y129.88 E.02355
G1 X111.32 Y137.955 E.41414
G1 X110.671 Y137.955 E.02355
G1 X103.245 Y130.529 E.38084
G1 X103.245 Y131.179 E.02355
G1 X110.021 Y137.955 E.34754
G1 X109.372 Y137.955 E.02355
G1 X103.245 Y131.828 E.31424
G1 X103.245 Y132.477 E.02355
G1 X108.723 Y137.955 E.28093
G1 X108.074 Y137.955 E.02355
G1 X103.245 Y133.126 E.24763
G1 X103.245 Y133.776 E.02355
G1 X107.424 Y137.955 E.21433
G1 X106.775 Y137.955 E.02355
G1 X103.245 Y134.425 E.18103
G1 X103.245 Y135.074 E.02355
G1 X106.126 Y137.955 E.14773
G1 X105.476 Y137.955 E.02355
G1 X103.245 Y135.724 E.11442
G1 X103.245 Y136.373 E.02355
G1 X104.827 Y137.955 E.08112
G1 X104.755 Y137.955 E.00263
G1 X104.755 Y138.531 E.02091
G1 X103.245 Y137.022 E.0774
G1 X103.245 Y137.671 E.02355
G1 X104.755 Y139.18 E.0774
G1 X104.755 Y139.83 E.02355
G1 X103.245 Y138.321 E.0774
G1 X103.245 Y138.97 E.02355
G1 X104.96 Y140.685 E.08795
; WIPE_START
G1 X103.546 Y139.271 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X111.169 Y139.658 Z.6 F30000
G1 X152.115 Y141.74 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X152.754 Y142.379 E.03278
G1 X152.754 Y143.028 E.02354
G1 X151.671 Y141.945 E.05551
G1 X151.022 Y141.945 E.02355
G1 X152.754 Y143.677 E.0888
G1 X152.753 Y144.326 E.02354
G1 X150.373 Y141.945 E.12209
G1 X149.724 Y141.945 E.02355
G1 X152.753 Y144.975 E.15538
G1 X152.753 Y145.624 E.02354
G1 X149.074 Y141.945 E.18866
G1 X148.425 Y141.945 E.02355
G1 X152.752 Y146.273 E.22195
G1 X152.752 Y146.922 E.02354
G1 X147.776 Y141.945 E.25524
G1 X147.126 Y141.945 E.02355
G1 X152.752 Y147.571 E.28852
G1 X152.751 Y148.22 E.02354
G1 X146.477 Y141.945 E.32181
G1 X145.828 Y141.945 E.02355
G1 X152.751 Y148.869 E.3551
G1 X152.751 Y149.518 E.02354
G1 X145.179 Y141.945 E.38838
G1 X144.529 Y141.945 E.02355
G1 X152.651 Y150.067 E.41655
G3 X152.314 Y150.379 I-.694 J-.412 E.0169
G1 X143.88 Y141.945 E.43256
G1 X143.231 Y141.945 E.02355
G1 X151.74 Y150.455 E.43642
G1 X151.09 Y150.455 E.02355
G1 X142.581 Y141.945 E.43642
M73 P15 R13
G1 X141.932 Y141.945 E.02355
G1 X150.441 Y150.455 E.43642
G1 X149.792 Y150.455 E.02355
G1 X141.283 Y141.945 E.43642
G1 X140.633 Y141.945 E.02355
G1 X149.143 Y150.455 E.43642
G1 X148.493 Y150.455 E.02355
G1 X139.984 Y141.945 E.43642
G1 X139.335 Y141.945 E.02355
G1 X147.844 Y150.455 E.43642
G1 X147.195 Y150.455 E.02355
G1 X138.686 Y141.945 E.43642
G1 X138.036 Y141.945 E.02355
G1 X146.545 Y150.455 E.43642
G1 X145.896 Y150.455 E.02355
G1 X137.387 Y141.945 E.43642
G1 X136.738 Y141.945 E.02355
G1 X145.247 Y150.455 E.43642
G1 X144.597 Y150.455 E.02355
G1 X136.088 Y141.945 E.43642
G1 X135.439 Y141.945 E.02355
G1 X143.948 Y150.455 E.43642
G1 X143.299 Y150.455 E.02355
G1 X134.79 Y141.945 E.43642
G1 X134.141 Y141.945 E.02355
G1 X142.65 Y150.455 E.43642
G1 X142 Y150.455 E.02355
G1 X133.491 Y141.945 E.43642
G1 X132.842 Y141.945 E.02355
G1 X141.351 Y150.455 E.43642
G1 X140.702 Y150.455 E.02355
G1 X132.193 Y141.945 E.43642
G1 X131.543 Y141.945 E.02355
G1 X133.152 Y143.555 E.08253
G1 X133.745 Y143.555 E.02151
G1 X133.745 Y144.148 E.02151
G1 X140.052 Y150.455 E.32348
G1 X139.403 Y150.455 E.02355
G1 X133.745 Y144.797 E.29018
G1 X133.745 Y145.446 E.02355
G1 X138.754 Y150.455 E.25688
G1 X138.105 Y150.455 E.02355
G1 X133.745 Y146.095 E.22357
G1 X133.745 Y146.745 E.02355
G1 X137.455 Y150.455 E.19027
G1 X136.806 Y150.455 E.02355
G1 X133.397 Y147.045 E.17485
G1 X132.748 Y147.045 E.02355
G1 X136.157 Y150.455 E.17485
G1 X135.507 Y150.455 E.02355
G1 X132.098 Y147.045 E.17485
G1 X131.449 Y147.045 E.02355
G1 X134.858 Y150.455 E.17485
G1 X134.209 Y150.455 E.02355
G1 X130.8 Y147.045 E.17485
G1 X130.15 Y147.045 E.02355
G1 X133.559 Y150.455 E.17485
G1 X132.91 Y150.455 E.02355
G1 X129.501 Y147.045 E.17485
G1 X128.852 Y147.045 E.02355
G1 X132.261 Y150.455 E.17485
G1 X131.612 Y150.455 E.02355
G1 X128.203 Y147.045 E.17485
G1 X127.553 Y147.045 E.02355
G1 X130.962 Y150.455 E.17485
G1 X130.313 Y150.455 E.02355
G1 X126.904 Y147.045 E.17485
G1 X126.255 Y147.045 E.02355
G1 X129.664 Y150.455 E.17485
G1 X129.014 Y150.455 E.02355
G1 X125.605 Y147.045 E.17485
M73 P16 R13
G1 X124.956 Y147.045 E.02355
G1 X128.365 Y150.455 E.17485
G1 X127.716 Y150.455 E.02355
G1 X124.307 Y147.045 E.17485
G1 X123.657 Y147.045 E.02355
G1 X127.067 Y150.455 E.17485
G1 X126.417 Y150.455 E.02355
G1 X123.008 Y147.045 E.17485
G1 X122.359 Y147.045 E.02355
G1 X125.768 Y150.455 E.17485
G1 X125.119 Y150.455 E.02355
G1 X121.71 Y147.045 E.17485
G1 X121.06 Y147.045 E.02355
G1 X124.469 Y150.455 E.17485
G1 X123.82 Y150.455 E.02355
G1 X120.411 Y147.045 E.17485
G1 X119.762 Y147.045 E.02355
G1 X123.171 Y150.455 E.17485
G1 X122.521 Y150.455 E.02355
G1 X119.112 Y147.045 E.17485
G1 X118.463 Y147.045 E.02355
G1 X121.872 Y150.455 E.17485
G1 X121.223 Y150.455 E.02355
G1 X117.814 Y147.045 E.17485
G1 X117.165 Y147.045 E.02355
G1 X120.574 Y150.455 E.17485
G1 X119.924 Y150.455 E.02355
G1 X116.515 Y147.045 E.17485
G1 X115.866 Y147.045 E.02355
G1 X119.275 Y150.455 E.17485
G1 X118.626 Y150.455 E.02355
G1 X115.011 Y146.84 E.1854
; WIPE_START
G1 X116.425 Y148.254 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X118.182 Y150.66 Z.6 F30000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X109.167 Y141.645 E.46236
G1 X108.518 Y141.645 E.02355
G1 X117.327 Y150.455 E.45181
G1 X116.678 Y150.455 E.02355
G1 X107.869 Y141.645 E.45181
G1 X107.22 Y141.645 E.02355
G1 X116.029 Y150.455 E.45181
G1 X115.379 Y150.455 E.02355
G1 X106.57 Y141.645 E.45181
G1 X105.921 Y141.645 E.02355
G1 X114.73 Y150.455 E.45181
G1 X114.081 Y150.455 E.02355
G1 X105.272 Y141.645 E.45181
G1 X104.755 Y141.645 E.01875
G1 X104.755 Y141.128 E.01875
G1 X103.245 Y139.619 E.0774
G1 X103.245 Y140.269 E.02355
G1 X113.431 Y150.455 E.52243
G1 X112.782 Y150.455 E.02355
G1 X103.245 Y140.918 E.48913
G1 X103.245 Y141.567 E.02355
G1 X112.133 Y150.455 E.45583
G1 X111.483 Y150.455 E.02355
G1 X103.245 Y142.216 E.42252
G1 X103.245 Y142.866 E.02355
G1 X110.834 Y150.455 E.38922
G1 X110.185 Y150.455 E.02355
G1 X103.245 Y143.515 E.35592
G1 X103.245 Y144.164 E.02355
G1 X109.536 Y150.455 E.32262
G1 X108.886 Y150.455 E.02355
G1 X103.245 Y144.814 E.28932
G1 X103.245 Y145.463 E.02355
G1 X108.237 Y150.455 E.25601
G1 X107.588 Y150.455 E.02355
G1 X103.245 Y146.112 E.22271
G1 X103.245 Y146.762 E.02355
G1 X106.938 Y150.455 E.18941
G1 X106.289 Y150.455 E.02355
G1 X103.245 Y147.411 E.15611
M73 P17 R13
G1 X103.245 Y148.06 E.02355
G1 X105.64 Y150.455 E.12281
G1 X104.991 Y150.455 E.02355
G1 X103.245 Y148.709 E.0895
G1 X103.245 Y149.359 E.02355
G1 X104.341 Y150.455 E.0562
G3 X103.727 Y150.4 I-.168 J-1.593 E.0225
G3 X103.447 Y150.209 I.278 J-.709 E.0124
G1 X103.049 Y149.812 E.02039
; WIPE_START
G1 X103.447 Y150.209 E-.21364
G1 X103.577 Y150.321 E-.06524
G1 X103.727 Y150.4 E-.06438
G1 X103.89 Y150.444 E-.06412
G1 X104.341 Y150.455 E-.17149
G1 X104.004 Y150.117 E-.18113
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X111.286 Y147.831 Z.6 F30000
G1 X130.688 Y141.74 Z.6
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X132.503 Y143.555 E.09308
G1 X131.854 Y143.555 E.02355
G1 X130.245 Y141.945 E.08253
G1 X129.595 Y141.945 E.02355
G1 X131.205 Y143.555 E.08253
G1 X130.555 Y143.555 E.02355
G1 X128.946 Y141.945 E.08253
G1 X128.297 Y141.945 E.02355
G1 X129.906 Y143.555 E.08253
G1 X129.257 Y143.555 E.02355
G1 X127.648 Y141.945 E.08253
G1 X126.998 Y141.945 E.02355
G1 X128.607 Y143.555 E.08253
G1 X127.958 Y143.555 E.02355
G1 X126.349 Y141.945 E.08253
G1 X125.7 Y141.945 E.02355
G1 X127.309 Y143.555 E.08253
G1 X126.659 Y143.555 E.02355
G1 X125.05 Y141.945 E.08253
G1 X124.401 Y141.945 E.02355
G1 X126.01 Y143.555 E.08253
G1 X125.361 Y143.555 E.02355
G1 X123.752 Y141.945 E.08253
G1 X123.103 Y141.945 E.02355
G1 X124.712 Y143.555 E.08253
G1 X124.062 Y143.555 E.02355
G1 X122.453 Y141.945 E.08253
G1 X121.804 Y141.945 E.02355
M73 P17 R12
G1 X123.413 Y143.555 E.08253
G1 X122.764 Y143.555 E.02355
G1 X121.155 Y141.945 E.08253
G1 X120.505 Y141.945 E.02355
G1 X122.114 Y143.555 E.08253
G1 X121.465 Y143.555 E.02355
G1 X119.856 Y141.945 E.08253
G1 X119.245 Y141.945 E.02215
G1 X119.245 Y141.984 E.0014
G1 X120.816 Y143.555 E.08054
G1 X120.167 Y143.555 E.02355
G1 X119.245 Y142.633 E.04724
G1 X119.245 Y143.283 E.02355
G1 X119.723 Y143.76 E.02449
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6300
G1 X119.245 Y143.283 E-.25658
G1 X119.245 Y142.633 E-.24673
G1 X119.723 Y143.111 E-.25669
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 2/22
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
M204 S10000
G17
G3 Z.6 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.598 Y122.232
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.612 Y122.199 E.00116
G3 X127.88 Y121.402 I1.387 J.801 E.05011
G1 X128 Y121.398 E.00386
G3 X126.469 Y122.528 I0 J1.602 E.25813
G1 X126.574 Y122.287 E.00845
M204 S250
G1 X126.959 Y122.397 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
G1 X127.054 Y122.245 E.00532
G3 X127.909 Y121.793 I.946 J.754 E.02966
G1 X128 Y121.79 E.0027
G3 X126.91 Y122.475 I0 J1.21 E.18596
G1 X126.927 Y122.447 E.00097
; WIPE_START
M204 S10000
G1 X127.054 Y122.245 E-.09063
G1 X127.245 Y122.054 E-.10299
G1 X127.395 Y121.952 E-.06874
G1 X127.643 Y121.844 E-.10296
G1 X127.909 Y121.793 E-.10294
G1 X128 Y121.79 E-.03442
G1 X128.269 Y121.82 E-.103
G1 X128.442 Y121.874 E-.06873
G1 X128.605 Y121.952 E-.06868
G1 X128.641 Y121.978 E-.0169
; WIPE_END
G1 E-.04 F1800
G1 X136.267 Y122.288 Z.8 F30000
G1 X142.527 Y122.543 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.561 Y122.644 E.00342
G3 X140.88 Y121.402 I-1.562 J.356 E.25044
G1 X141 Y121.398 E.00386
G3 X142.443 Y122.305 I0 J1.602 E.0578
G1 X142.507 Y122.486 E.00618
M204 S250
G1 X142.159 Y122.672 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
G1 X142.179 Y122.731 E.00186
G3 X140.909 Y121.793 I-1.179 J.269 E.17519
G1 X141 Y121.79 E.0027
G3 X142.09 Y122.475 I0 J1.21 E.04044
G1 X142.139 Y122.615 E.00442
; WIPE_START
M204 S10000
G1 X142.179 Y122.731 E-.04651
G1 X142.207 Y122.909 E-.06871
G1 X142.197 Y123.18 E-.10296
G1 X142.156 Y123.357 E-.06877
G1 X142.048 Y123.605 E-.10298
G1 X141.946 Y123.755 E-.06873
G1 X141.754 Y123.946 E-.10298
G1 X141.605 Y124.048 E-.06874
G1 X141.357 Y124.156 E-.10295
G1 X141.288 Y124.169 E-.02667
; WIPE_END
G1 E-.04 F1800
G1 X134.093 Y121.622 Z.8 F30000
G1 X117.656 Y115.802 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.08867
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y104.802 E.07088
G1 X118.602 Y104.802 E.46627
G1 X118.602 Y113.598 E.28284
G1 X133.102 Y113.598 E.46627
G1 X133.102 Y115.802 E.07088
G1 X117.716 Y115.802 E.49478
; WIPE_START
G1 X115.716 Y115.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y113.99 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y113.99 E.43191
G1 X132.71 Y115.41 E.0423
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y104.41 E.0423
G1 X118.21 Y104.41 E.43191
G1 X118.21 Y113.93 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y113.938 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.647 Y110.043 Z.8 F30000
G1 X110.202 Y107.998 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.221 Y115.621 Z.8 F30000
G1 X116.522 Y122.529 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.561 Y122.644 E.0039
G3 X114.88 Y121.402 I-1.562 J.356 E.25044
G1 X115 Y121.398 E.00386
G3 X116.443 Y122.305 I0 J1.602 E.0578
G1 X116.502 Y122.472 E.00571
M204 S250
G1 X116.154 Y122.658 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
G1 X116.179 Y122.731 E.0023
G3 X114.909 Y121.793 I-1.179 J.269 E.17519
G1 X115 Y121.79 E.0027
G3 X116.09 Y122.475 I0 J1.21 E.04044
G1 X116.134 Y122.601 E.00398
; WIPE_START
M204 S10000
G1 X116.179 Y122.731 E-.05214
G1 X116.207 Y122.909 E-.06871
G1 X116.197 Y123.18 E-.10296
G1 X116.156 Y123.357 E-.06877
G1 X116.048 Y123.605 E-.10298
G1 X115.946 Y123.755 E-.06873
G1 X115.754 Y123.946 E-.10298
G1 X115.605 Y124.048 E-.06874
G1 X115.357 Y124.156 E-.10295
G1 X115.302 Y124.167 E-.02104
; WIPE_END
G1 E-.04 F1800
G1 X116.106 Y131.757 Z.8 F30000
G1 X117.656 Y146.402 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.08868
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y135.402 E.07088
G1 X118.602 Y135.402 E.46627
G1 X118.602 Y144.198 E.28284
G1 X133.102 Y144.198 E.46627
G1 X133.102 Y146.402 E.07088
M73 P18 R12
G1 X117.716 Y146.402 E.49477
; WIPE_START
G1 X115.716 Y146.402 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y144.59 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y144.59 E.43191
G1 X132.71 Y146.01 E.0423
G1 X115.29 Y146.01 E.51888
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y135.01 E.0423
G1 X118.21 Y135.01 E.43191
G1 X118.21 Y144.53 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y144.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.153 Y141.631 Z.8 F30000
G1 X105.79 Y138.598 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.407 Y138.55 Z.8 F30000
G1 X119.398 Y138.298 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X119.398 Y141.302 E.0966
G1 X153.398 Y141.302 E1.09332
G1 X153.398 Y149.689 E.26969
G3 X151.986 Y151.098 I-1.402 J.007 E.07137
G1 X104.011 Y151.098 E1.54269
G3 X102.602 Y149.687 I-.008 J-1.401 E.07137
G1 X102.602 Y102.311 E1.52342
G3 X104.014 Y100.902 I1.402 J-.007 E.07137
G1 X152.01 Y100.903 E1.54338
G3 X153.398 Y102.311 I-.013 J1.4 E.07059
G1 X153.398 Y107.698 E.17322
G1 X119.398 Y107.698 E1.09332
G1 X119.398 Y110.702 E.0966
G1 X153.398 Y110.702 E1.09332
G1 X153.398 Y138.298 E.88738
G1 X119.458 Y138.298 E1.09139
M204 S250
G1 X119.79 Y138.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X119.79 Y140.91 E.06613
G1 X153.79 Y140.91 E1.01274
G1 X153.79 Y149.696 E.26171
G3 X151.995 Y151.49 I-1.794 J0 E.08397
G1 X104.004 Y151.49 E1.42949
G3 X102.21 Y149.695 I-.001 J-1.793 E.08398
G1 X102.21 Y102.304 E1.41163
G3 X104.005 Y100.51 I1.794 J0 E.08397
G1 X152.018 Y100.511 E1.43013
G3 X153.79 Y102.304 I-.02 J1.792 E.08329
G1 X153.79 Y108.09 E.17235
G1 X119.79 Y108.09 E1.01274
G1 X119.79 Y110.31 E.06613
G1 X153.79 Y110.31 E1.01274
G1 X153.79 Y138.69 E.84534
G1 X119.85 Y138.69 E1.01096
; WIPE_START
M204 S10000
G1 X119.796 Y140.689 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119 Y138.095 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y141.506 E.10476
G1 X119.284 Y141.669 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42108
G1 F15000
G1 X118.935 Y142.018 E.01472
G1 X118.935 Y142.552 E.01598
G1 X119.852 Y141.635 E.03874
G1 X120.387 Y141.635 E.01598
G1 X118.935 Y143.087 E.06134
G1 X118.935 Y143.622 E.01598
G1 X120.922 Y141.635 E.08393
G1 X121.457 Y141.635 E.01598
G1 X119.227 Y143.865 E.09418
G1 X119.762 Y143.865 E.01598
G1 X121.992 Y141.635 E.09418
G1 X122.526 Y141.635 E.01598
G1 X120.297 Y143.865 E.09418
G1 X120.832 Y143.865 E.01598
G1 X123.061 Y141.635 E.09418
G1 X123.596 Y141.635 E.01598
G1 X121.367 Y143.865 E.09418
G1 X121.901 Y143.865 E.01598
G1 X124.131 Y141.635 E.09418
G1 X124.666 Y141.635 E.01598
G1 X122.436 Y143.865 E.09418
G1 X122.971 Y143.865 E.01598
G1 X125.2 Y141.635 E.09418
G1 X125.735 Y141.635 E.01598
G1 X123.506 Y143.865 E.09418
G1 X124.041 Y143.865 E.01598
G1 X126.27 Y141.635 E.09418
G1 X126.805 Y141.635 E.01598
G1 X124.575 Y143.865 E.09418
G1 X125.11 Y143.865 E.01598
G1 X127.34 Y141.635 E.09418
G1 X127.874 Y141.635 E.01598
G1 X125.645 Y143.865 E.09418
G1 X126.18 Y143.865 E.01598
G1 X128.409 Y141.635 E.09418
G1 X128.944 Y141.635 E.01598
G1 X126.715 Y143.865 E.09418
G1 X127.249 Y143.865 E.01598
G1 X129.479 Y141.635 E.09418
G1 X130.014 Y141.635 E.01598
G1 X127.784 Y143.865 E.09418
G1 X128.319 Y143.865 E.01598
G1 X130.548 Y141.635 E.09418
G1 X131.083 Y141.635 E.01598
G1 X128.854 Y143.865 E.09418
G1 X129.389 Y143.865 E.01598
G1 X131.618 Y141.635 E.09418
G1 X132.153 Y141.635 E.01598
G1 X129.923 Y143.865 E.09418
G1 X130.458 Y143.865 E.01598
G1 X132.688 Y141.635 E.09418
G1 X133.222 Y141.635 E.01598
G1 X130.993 Y143.865 E.09418
G1 X131.528 Y143.865 E.01598
G1 X133.757 Y141.635 E.09418
G1 X134.292 Y141.635 E.01598
G1 X132.063 Y143.865 E.09418
G1 X132.597 Y143.865 E.01598
G1 X134.827 Y141.635 E.09418
G1 X135.362 Y141.635 E.01598
G1 X133.132 Y143.865 E.09418
G1 X133.435 Y143.865 E.00905
G1 X133.435 Y144.096 E.00692
G1 X135.896 Y141.635 E.10397
G1 X136.431 Y141.635 E.01598
G1 X133.435 Y144.631 E.12656
G1 X133.435 Y145.166 E.01598
G1 X136.966 Y141.635 E.14915
G1 X137.501 Y141.635 E.01598
G1 X133.435 Y145.701 E.17175
G1 X133.435 Y146.236 E.01598
G1 X138.036 Y141.635 E.19434
G1 X138.57 Y141.635 E.01598
G1 X129.441 Y150.765 E.38567
G1 X129.976 Y150.765 E.01598
G1 X139.105 Y141.635 E.38567
G1 X139.64 Y141.635 E.01598
G1 X130.511 Y150.765 E.38567
G1 X131.045 Y150.765 E.01598
G1 X140.175 Y141.635 E.38567
G1 X140.71 Y141.635 E.01598
G1 X131.58 Y150.765 E.38567
G1 X132.115 Y150.765 E.01598
G1 X141.244 Y141.635 E.38567
G1 X141.779 Y141.635 E.01598
G1 X132.65 Y150.765 E.38567
G1 X133.185 Y150.765 E.01598
G1 X142.314 Y141.635 E.38567
G1 X142.849 Y141.635 E.01598
G1 X133.719 Y150.765 E.38567
G1 X134.254 Y150.765 E.01598
G1 X143.384 Y141.635 E.38567
G1 X143.918 Y141.635 E.01598
G1 X134.789 Y150.765 E.38567
G1 X135.324 Y150.765 E.01598
G1 X144.453 Y141.635 E.38567
G1 X144.988 Y141.635 E.01598
G1 X135.859 Y150.765 E.38567
G1 X136.393 Y150.765 E.01598
G1 X145.523 Y141.635 E.38567
G1 X146.058 Y141.635 E.01598
G1 X136.928 Y150.765 E.38567
G1 X137.463 Y150.765 E.01598
G1 X146.592 Y141.635 E.38567
G1 X147.127 Y141.635 E.01598
G1 X137.998 Y150.765 E.38567
G1 X138.533 Y150.765 E.01598
G1 X147.662 Y141.635 E.38567
G1 X148.197 Y141.635 E.01598
G1 X139.067 Y150.765 E.38567
G1 X139.602 Y150.765 E.01598
G1 X148.732 Y141.635 E.38567
G1 X149.266 Y141.635 E.01598
G1 X140.137 Y150.765 E.38567
G1 X140.672 Y150.765 E.01598
G1 X149.801 Y141.635 E.38567
G1 X150.336 Y141.635 E.01598
G1 X141.207 Y150.765 E.38567
G1 X141.741 Y150.765 E.01598
G1 X150.871 Y141.635 E.38567
G1 X151.406 Y141.635 E.01598
G1 X142.276 Y150.765 E.38567
M73 P19 R12
G1 X142.811 Y150.765 E.01598
G1 X151.94 Y141.635 E.38567
G1 X152.475 Y141.635 E.01598
G1 X143.346 Y150.765 E.38567
G1 X143.881 Y150.765 E.01598
G1 X153.01 Y141.635 E.38567
G1 X153.065 Y141.635 E.00163
G1 X153.064 Y142.116 E.01435
G1 X144.415 Y150.765 E.36537
G1 X144.95 Y150.765 E.01598
G1 X153.064 Y142.651 E.34277
G1 X153.064 Y143.186 E.01598
G1 X145.485 Y150.765 E.32017
G1 X146.02 Y150.765 E.01598
G1 X153.063 Y143.721 E.29756
G1 X153.063 Y144.256 E.01598
G1 X146.555 Y150.765 E.27496
G1 X147.089 Y150.765 E.01598
G1 X153.063 Y144.791 E.25235
G1 X153.063 Y145.326 E.01598
G1 X147.624 Y150.765 E.22975
G1 X148.159 Y150.765 E.01598
G1 X153.062 Y145.861 E.20715
G1 X153.062 Y146.396 E.01598
G1 X148.694 Y150.765 E.18454
G1 X149.229 Y150.765 E.01598
G1 X153.062 Y146.931 E.16194
G1 X153.062 Y147.466 E.01598
G1 X149.763 Y150.765 E.13933
G1 X150.298 Y150.765 E.01598
G1 X153.061 Y148.002 E.11673
G1 X153.061 Y148.537 E.01598
G1 X150.833 Y150.765 E.09413
G1 X151.368 Y150.765 E.01598
G1 X153.061 Y149.072 E.07152
G1 X153.061 Y149.607 E.01598
G1 X151.733 Y150.934 E.05609
; WIPE_START
G1 X153.061 Y149.607 E-.71348
G1 X153.061 Y149.484 E-.04652
; WIPE_END
G1 E-.04 F1800
G1 X152.863 Y141.854 Z.8 F30000
G1 X152.767 Y138.134 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X153.065 Y137.837 E.01256
G1 X153.065 Y137.302 E.01598
G1 X152.402 Y137.965 E.02799
G1 X151.867 Y137.965 E.01598
G1 X153.065 Y136.767 E.05058
G1 X153.065 Y136.233 E.01598
G1 X151.333 Y137.965 E.07317
G1 X150.798 Y137.965 E.01598
G1 X153.065 Y135.698 E.09576
G1 X153.065 Y135.163 E.01598
G1 X150.263 Y137.965 E.11836
G1 X149.728 Y137.965 E.01598
G1 X153.065 Y134.628 E.14095
G1 X153.065 Y134.093 E.01598
G1 X149.193 Y137.965 E.16354
G1 X148.659 Y137.965 E.01598
G1 X153.065 Y133.559 E.18614
G1 X153.065 Y133.024 E.01598
G1 X148.124 Y137.965 E.20873
G1 X147.589 Y137.965 E.01598
G1 X153.065 Y132.489 E.23132
G1 X153.065 Y131.954 E.01598
G1 X147.054 Y137.965 E.25391
G1 X146.519 Y137.965 E.01598
G1 X153.065 Y131.419 E.27651
G1 X153.065 Y130.885 E.01598
G1 X145.985 Y137.965 E.2991
G1 X145.45 Y137.965 E.01598
G1 X153.065 Y130.35 E.32169
G1 X153.065 Y129.815 E.01598
G1 X144.915 Y137.965 E.34428
G1 X144.38 Y137.965 E.01598
G1 X153.065 Y129.28 E.36688
G1 X153.065 Y128.745 E.01598
G1 X143.845 Y137.965 E.38947
G1 X143.311 Y137.965 E.01598
G1 X153.065 Y128.211 E.41206
G1 X153.065 Y127.676 E.01598
G1 X142.776 Y137.965 E.43465
G1 X142.241 Y137.965 E.01598
G1 X153.065 Y127.141 E.45725
G1 X153.065 Y126.606 E.01598
G1 X141.706 Y137.965 E.47984
G1 X141.171 Y137.965 E.01598
G1 X153.065 Y126.071 E.50243
G1 X153.065 Y125.537 E.01598
G1 X140.637 Y137.965 E.52503
G1 X140.102 Y137.965 E.01598
G1 X153.065 Y125.002 E.54762
G1 X153.065 Y124.467 E.01598
G1 X139.567 Y137.965 E.57021
G1 X139.032 Y137.965 E.01598
G1 X153.065 Y123.932 E.5928
G1 X153.065 Y123.397 E.01598
G1 X138.497 Y137.965 E.6154
G1 X137.963 Y137.965 E.01598
G1 X153.065 Y122.863 E.63799
G1 X153.065 Y122.328 E.01598
G1 X137.428 Y137.965 E.66058
G1 X136.893 Y137.965 E.01598
G1 X153.065 Y121.793 E.68317
G1 X153.065 Y121.258 E.01598
G1 X136.358 Y137.965 E.70577
G1 X135.823 Y137.965 E.01598
G1 X153.065 Y120.723 E.72836
G1 X153.065 Y120.189 E.01598
G1 X135.289 Y137.965 E.75095
G1 X134.754 Y137.965 E.01598
G1 X153.065 Y119.654 E.77355
G1 X153.065 Y119.119 E.01598
G1 X134.219 Y137.965 E.79614
G1 X133.684 Y137.965 E.01598
G1 X153.065 Y118.584 E.81873
G1 X153.065 Y118.049 E.01598
G1 X133.149 Y137.965 E.84132
G1 X132.615 Y137.965 E.01598
G1 X153.065 Y117.515 E.86392
G1 X153.065 Y116.98 E.01598
G1 X132.08 Y137.965 E.88651
G1 X131.545 Y137.965 E.01598
G1 X153.065 Y116.445 E.9091
G1 X153.065 Y115.91 E.01598
G1 X131.01 Y137.965 E.9317
G1 X130.475 Y137.965 E.01598
G1 X132.705 Y135.735 E.09418
G1 X132.17 Y135.735 E.01598
G1 X129.941 Y137.965 E.09418
G1 X129.406 Y137.965 E.01598
G1 X131.635 Y135.735 E.09418
G1 X131.1 Y135.735 E.01598
G1 X128.871 Y137.965 E.09418
G1 X128.336 Y137.965 E.01598
G1 X130.566 Y135.735 E.09418
G1 X130.031 Y135.735 E.01598
G1 X127.801 Y137.965 E.09418
G1 X127.267 Y137.965 E.01598
G1 X129.496 Y135.735 E.09418
G1 X128.961 Y135.735 E.01598
G1 X126.732 Y137.965 E.09418
G1 X126.197 Y137.965 E.01598
G1 X128.426 Y135.735 E.09418
G1 X127.892 Y135.735 E.01598
G1 X125.662 Y137.965 E.09418
G1 X125.127 Y137.965 E.01598
G1 X127.357 Y135.735 E.09418
G1 X126.822 Y135.735 E.01598
G1 X124.593 Y137.965 E.09418
G1 X124.058 Y137.965 E.01598
G1 X126.287 Y135.735 E.09418
G1 X125.752 Y135.735 E.01598
G1 X123.523 Y137.965 E.09418
G1 X122.988 Y137.965 E.01598
G1 X125.218 Y135.735 E.09418
G1 X124.683 Y135.735 E.01598
G1 X122.453 Y137.965 E.09418
G1 X121.919 Y137.965 E.01598
G1 X124.148 Y135.735 E.09418
G1 X123.613 Y135.735 E.01598
G1 X121.384 Y137.965 E.09418
G1 X120.849 Y137.965 E.01598
G1 X123.078 Y135.735 E.09418
G1 X122.544 Y135.735 E.01598
G1 X120.314 Y137.965 E.09418
G1 X119.779 Y137.965 E.01598
G1 X122.009 Y135.735 E.09418
G1 X121.474 Y135.735 E.01598
G1 X119.448 Y137.761 E.08559
G1 X118.935 Y137.761 E.01532
G1 X118.935 Y137.739 E.00066
G1 X120.939 Y135.735 E.08466
G1 X120.404 Y135.735 E.01598
G1 X118.935 Y137.204 E.06206
G1 X118.935 Y136.67 E.01598
G1 X119.87 Y135.735 E.03947
G1 X119.335 Y135.735 E.01598
G1 X118.766 Y136.305 E.02405
; WIPE_START
G1 X119.335 Y135.735 E-.30589
G1 X119.87 Y135.735 E-.20322
G1 X119.403 Y136.202 E-.25089
; WIPE_END
G1 E-.04 F1800
G1 X122.976 Y129.458 Z.8 F30000
G1 X127.234 Y121.418 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X132.517 Y116.135 E.22318
G1 X133.052 Y116.135 E.01598
G1 X128.119 Y121.069 E.20841
G1 X128.573 Y121.149 E.01379
G1 X138.687 Y111.035 E.42726
G1 X139.222 Y111.035 E.01598
G1 X128.945 Y121.312 E.43412
G3 X129.258 Y121.534 I-1.302 J2.154 E.01146
G1 X139.756 Y111.035 E.44353
G1 X140.291 Y111.035 E.01598
G1 X129.522 Y121.804 E.45494
G3 X129.724 Y122.137 I-.778 J.701 E.0117
G1 X140.826 Y111.035 E.46899
G1 X141.361 Y111.035 E.01598
G1 X129.87 Y122.526 E.48543
G3 X129.931 Y123 I-1.22 J.398 E.01435
G1 X141.896 Y111.035 E.50544
G1 X142.43 Y111.035 E.01598
G1 X129.417 Y124.049 E.54975
; WIPE_START
G1 X130.831 Y122.635 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.499 Y130.15 Z.8 F30000
G1 X128.988 Y133.034 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X139.075 Y122.948 E.42612
G2 X139.122 Y123.435 I1.091 J.14 E.01475
G1 X129.693 Y132.865 E.39836
G1 X130.227 Y132.865 E.01598
G1 X139.261 Y123.831 E.38164
G2 X139.459 Y124.168 I.99 J-.353 E.01174
G1 X130.762 Y132.865 E.36739
G1 X131.297 Y132.865 E.01598
G1 X139.719 Y124.443 E.3558
G2 X140.024 Y124.672 I.76 J-.692 E.01147
G1 X131.832 Y132.865 E.34609
G1 X132.367 Y132.865 E.01598
G1 X140.395 Y124.837 E.33914
G1 X140.837 Y124.929 E.0135
G1 X132.732 Y133.034 E.34241
; WIPE_START
G1 X134.146 Y131.62 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.266 Y135.174 Z.8 F30000
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X153.065 Y115.375 E.83642
G1 X153.065 Y114.841 E.01598
G1 X133.435 Y134.47 E.82925
G1 X133.435 Y133.935 E.01598
G1 X153.065 Y114.306 E.82925
G1 X153.065 Y113.771 E.01598
G1 X133.435 Y133.4 E.82925
G1 X133.435 Y132.866 E.01598
M73 P20 R12
G1 X141.421 Y124.88 E.33734
G2 X142.849 Y123.577 I-.397 J-1.87 E.06056
G1 X142.886 Y123.415 E.00498
G1 X153.065 Y113.236 E.42999
G1 X153.065 Y112.701 E.01598
G1 X142.929 Y122.837 E.42818
G1 X142.837 Y122.395 E.0135
G1 X153.065 Y112.167 E.43208
G1 X153.065 Y111.632 E.01598
G1 X142.672 Y122.024 E.43903
G2 X142.443 Y121.719 I-.921 J.454 E.01147
G1 X153.065 Y111.097 E.44874
G1 X153.065 Y111.035 E.00184
G1 X152.592 Y111.035 E.01413
G1 X142.168 Y121.459 E.44035
G2 X141.831 Y121.261 I-.69 J.793 E.01174
G1 X152.057 Y111.035 E.43201
G1 X151.522 Y111.035 E.01598
G1 X141.435 Y121.122 E.42613
G2 X140.954 Y121.069 I-.382 J1.244 E.01454
G1 X150.987 Y111.035 E.42386
G1 X150.452 Y111.035 E.01598
G1 X128.623 Y132.865 E.92219
G1 X128.088 Y132.865 E.01598
G1 X149.918 Y111.035 E.92219
G1 X149.383 Y111.035 E.01598
G1 X127.553 Y132.865 E.92219
G1 X127.019 Y132.865 E.01598
G1 X148.848 Y111.035 E.92219
G1 X148.313 Y111.035 E.01598
G1 X126.484 Y132.865 E.92219
G1 X125.949 Y132.865 E.01598
G1 X147.778 Y111.035 E.92219
G1 X147.244 Y111.035 E.01598
G1 X125.414 Y132.865 E.92219
G1 X124.879 Y132.865 E.01598
G1 X146.709 Y111.035 E.92219
G1 X146.174 Y111.035 E.01598
G1 X124.345 Y132.865 E.92219
G1 X123.81 Y132.865 E.01598
G1 X145.639 Y111.035 E.92219
G1 X145.104 Y111.035 E.01598
G1 X123.275 Y132.865 E.92219
G1 X122.74 Y132.865 E.01598
G1 X144.57 Y111.035 E.92219
G1 X144.035 Y111.035 E.01598
G1 X122.205 Y132.865 E.92219
G1 X121.671 Y132.865 E.01598
G1 X143.5 Y111.035 E.92219
G1 X142.965 Y111.035 E.01598
G1 X121.136 Y132.865 E.92219
G1 X120.601 Y132.865 E.01598
G1 X128.647 Y124.819 E.33991
G1 X128.571 Y124.852 E.00247
G1 X128.151 Y124.931 E.01278
G1 X128 Y124.931 E.00452
G1 X120.066 Y132.865 E.33515
G1 X119.531 Y132.865 E.01598
G1 X127.526 Y124.87 E.33773
G1 X127.429 Y124.852 E.00296
G1 X127.137 Y124.724 E.00951
G1 X118.997 Y132.865 E.34389
G1 X118.462 Y132.865 E.01598
G1 X126.804 Y124.522 E.35243
G1 X126.534 Y124.258 E.0113
G1 X117.927 Y132.865 E.36361
G1 X117.392 Y132.865 E.01598
G1 X126.312 Y123.945 E.3768
G1 X126.149 Y123.573 E.01214
G1 X116.857 Y132.865 E.39253
G1 X116.323 Y132.865 E.01598
G1 X126.069 Y123.119 E.41172
G3 X126.131 Y122.522 I1.607 J-.135 E.01803
G1 X115.788 Y132.865 E.43693
G1 X115.253 Y132.865 E.01598
G1 X131.982 Y116.135 E.70674
G1 X131.448 Y116.135 E.01598
G1 X109.318 Y138.265 E.93486
G1 X109.853 Y138.265 E.01598
G1 X114.565 Y133.553 E.19904
G1 X114.565 Y134.088 E.01598
G1 X110.388 Y138.265 E.17645
G1 X110.923 Y138.265 E.01598
G1 X114.565 Y134.623 E.15386
G1 X114.565 Y135.157 E.01598
G1 X111.457 Y138.265 E.13126
G1 X111.992 Y138.265 E.01598
G1 X114.565 Y135.692 E.10867
G1 X114.565 Y136.227 E.01598
G1 X112.527 Y138.265 E.08608
G1 X112.935 Y138.265 E.01219
G1 X112.935 Y138.391 E.00378
G1 X114.565 Y136.762 E.06883
G1 X114.565 Y137.297 E.01598
G1 X112.935 Y138.926 E.06883
G1 X112.935 Y139.461 E.01598
G1 X114.565 Y137.831 E.06883
G1 X114.565 Y138.366 E.01598
G1 X112.935 Y139.996 E.06883
G1 X112.935 Y140.53 E.01598
G1 X114.565 Y138.901 E.06883
G1 X114.565 Y139.436 E.01598
G1 X103.415 Y150.585 E.471
G2 X103.796 Y150.739 I.539 J-.783 E.01237
G1 X114.565 Y139.971 E.45492
G1 X114.565 Y140.505 E.01598
G1 X104.305 Y150.765 E.4334
G1 X104.84 Y150.765 E.01598
G1 X114.565 Y141.04 E.41081
G1 X114.565 Y141.575 E.01598
G1 X105.375 Y150.765 E.38822
G1 X105.91 Y150.765 E.01598
G1 X114.565 Y142.11 E.36562
G1 X114.565 Y142.645 E.01598
G1 X106.445 Y150.765 E.34303
G1 X106.979 Y150.765 E.01598
G1 X114.565 Y143.179 E.32044
G1 X114.565 Y143.714 E.01598
G1 X107.514 Y150.765 E.29785
G1 X108.049 Y150.765 E.01598
G1 X114.565 Y144.249 E.27525
G1 X114.565 Y144.784 E.01598
G1 X108.584 Y150.765 E.25266
G1 X109.119 Y150.765 E.01598
G1 X114.565 Y145.319 E.23007
G1 X114.565 Y145.853 E.01598
G1 X109.653 Y150.765 E.20748
G1 X110.188 Y150.765 E.01598
G1 X114.565 Y146.388 E.18488
G1 X114.565 Y146.735 E.01037
G1 X114.752 Y146.735 E.00561
G1 X110.723 Y150.765 E.17022
G1 X111.258 Y150.765 E.01598
G1 X115.287 Y146.735 E.17022
G1 X115.822 Y146.735 E.01598
G1 X111.793 Y150.765 E.17022
G1 X112.327 Y150.765 E.01598
G1 X116.357 Y146.735 E.17022
G1 X116.892 Y146.735 E.01598
G1 X112.862 Y150.765 E.17022
G1 X113.397 Y150.765 E.01598
G1 X117.426 Y146.735 E.17022
G1 X117.961 Y146.735 E.01598
G1 X113.932 Y150.765 E.17022
G1 X114.467 Y150.765 E.01598
G1 X118.496 Y146.735 E.17022
G1 X119.031 Y146.735 E.01598
G1 X115.001 Y150.765 E.17022
G1 X115.536 Y150.765 E.01598
G1 X119.566 Y146.735 E.17022
G1 X120.1 Y146.735 E.01598
G1 X116.071 Y150.765 E.17022
G1 X116.606 Y150.765 E.01598
G1 X120.635 Y146.735 E.17022
G1 X121.17 Y146.735 E.01598
G1 X117.141 Y150.765 E.17022
G1 X117.675 Y150.765 E.01598
G1 X121.705 Y146.735 E.17022
G1 X122.24 Y146.735 E.01598
G1 X118.21 Y150.765 E.17022
G1 X118.745 Y150.765 E.01598
G1 X122.774 Y146.735 E.17022
G1 X123.309 Y146.735 E.01598
G1 X119.28 Y150.765 E.17022
G1 X119.815 Y150.765 E.01598
G1 X123.844 Y146.735 E.17022
G1 X124.379 Y146.735 E.01598
G1 X120.349 Y150.765 E.17022
G1 X120.884 Y150.765 E.01598
G1 X124.914 Y146.735 E.17022
G1 X125.448 Y146.735 E.01598
G1 X121.419 Y150.765 E.17022
G1 X121.954 Y150.765 E.01598
G1 X125.983 Y146.735 E.17022
G1 X126.518 Y146.735 E.01598
G1 X122.489 Y150.765 E.17022
G1 X123.023 Y150.765 E.01598
G1 X127.053 Y146.735 E.17022
G1 X127.588 Y146.735 E.01598
G1 X123.558 Y150.765 E.17022
G1 X124.093 Y150.765 E.01598
G1 X128.122 Y146.735 E.17022
G1 X128.657 Y146.735 E.01598
G1 X124.628 Y150.765 E.17022
G1 X125.163 Y150.765 E.01598
G1 X129.192 Y146.735 E.17022
G1 X129.727 Y146.735 E.01598
G1 X125.697 Y150.765 E.17022
G1 X126.232 Y150.765 E.01598
G1 X130.262 Y146.735 E.17022
G1 X130.796 Y146.735 E.01598
G1 X126.767 Y150.765 E.17022
G1 X127.302 Y150.765 E.01598
G1 X131.331 Y146.735 E.17022
G1 X131.866 Y146.735 E.01598
G1 X127.837 Y150.765 E.17022
G1 X128.371 Y150.765 E.01598
G1 X132.401 Y146.735 E.17022
G1 X132.936 Y146.735 E.01598
G1 X128.737 Y150.934 E.17739
; WIPE_START
G1 X130.151 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.68 Y141.906 Z.8 F30000
G1 X133.266 Y104.691 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X136.721 Y101.236 E.14596
G1 X136.186 Y101.236 E.01598
G1 X133.435 Y103.986 E.1162
G1 X133.435 Y103.452 E.01598
G1 X135.651 Y101.236 E.09361
G1 X135.116 Y101.236 E.01598
G1 X133.435 Y102.917 E.07102
G1 X133.435 Y102.382 E.01598
G1 X134.582 Y101.236 E.04842
G1 X134.047 Y101.236 E.01598
G1 X133.018 Y102.265 E.04346
G1 X132.483 Y102.265 E.01598
G1 X133.512 Y101.236 E.04346
G1 X132.977 Y101.236 E.01598
G1 X131.948 Y102.265 E.04347
G1 X131.414 Y102.265 E.01598
G1 X132.442 Y101.236 E.04347
G1 X131.908 Y101.236 E.01597
G1 X130.879 Y102.265 E.04347
G1 X130.344 Y102.265 E.01598
G1 X131.373 Y101.236 E.04347
G1 X130.838 Y101.236 E.01598
G1 X129.809 Y102.265 E.04347
G1 X129.274 Y102.265 E.01598
G1 X130.303 Y101.236 E.04347
G1 X129.768 Y101.236 E.01597
G1 X128.74 Y102.265 E.04347
G1 X128.205 Y102.265 E.01598
G1 X129.234 Y101.236 E.04347
G1 X128.699 Y101.236 E.01598
G1 X127.67 Y102.265 E.04347
G1 X127.135 Y102.265 E.01598
G1 X128.164 Y101.236 E.04347
G1 X127.629 Y101.236 E.01598
G1 X126.6 Y102.265 E.04347
G1 X126.066 Y102.265 E.01598
G1 X127.095 Y101.236 E.04347
G1 X126.56 Y101.236 E.01598
G1 X125.531 Y102.265 E.04347
G1 X124.996 Y102.265 E.01598
G1 X126.025 Y101.236 E.04347
G1 X125.49 Y101.236 E.01598
G1 X124.461 Y102.265 E.04347
G1 X123.926 Y102.265 E.01598
M73 P21 R12
G1 X124.955 Y101.236 E.04347
G1 X124.421 Y101.236 E.01598
G1 X123.392 Y102.265 E.04347
G1 X122.857 Y102.265 E.01598
G1 X123.886 Y101.236 E.04347
G1 X123.351 Y101.236 E.01598
G1 X122.322 Y102.265 E.04347
G1 X121.787 Y102.265 E.01598
G1 X122.816 Y101.236 E.04347
G1 X122.281 Y101.236 E.01598
G1 X121.252 Y102.265 E.04347
G1 X120.718 Y102.265 E.01598
G1 X121.747 Y101.236 E.04347
G1 X121.212 Y101.236 E.01598
G1 X120.183 Y102.265 E.04347
G1 X119.648 Y102.265 E.01598
G1 X120.677 Y101.236 E.04347
G1 X120.142 Y101.236 E.01598
G1 X119.113 Y102.265 E.04347
G1 X118.578 Y102.265 E.01598
G1 X119.607 Y101.236 E.04347
G1 X119.073 Y101.236 E.01598
G1 X118.044 Y102.265 E.04347
G1 X117.509 Y102.265 E.01598
G1 X118.538 Y101.236 E.04348
G1 X118.003 Y101.236 E.01598
G1 X116.974 Y102.265 E.04348
G1 X116.439 Y102.265 E.01598
G1 X117.468 Y101.236 E.04348
G1 X116.934 Y101.236 E.01597
G1 X115.904 Y102.265 E.04348
G1 X115.37 Y102.265 E.01598
G1 X116.399 Y101.236 E.04348
G1 X115.864 Y101.236 E.01598
G1 X110.535 Y106.564 E.22511
G1 X110.535 Y106.029 E.01598
G1 X115.329 Y101.236 E.20252
G1 X114.794 Y101.235 E.01597
G1 X110.535 Y105.495 E.17992
G1 X110.535 Y105.265 E.00687
G1 X110.23 Y105.265 E.00911
G1 X114.26 Y101.235 E.17021
G1 X113.725 Y101.235 E.01598
G1 X109.696 Y105.265 E.17021
G1 X109.161 Y105.265 E.01598
G1 X113.19 Y101.235 E.17021
G1 X112.655 Y101.235 E.01598
G1 X108.626 Y105.265 E.17022
G1 X108.091 Y105.265 E.01598
G1 X112.12 Y101.235 E.17022
G1 X111.586 Y101.235 E.01598
G1 X102.935 Y109.886 E.36543
G1 X102.935 Y109.351 E.01598
G1 X111.051 Y101.235 E.34284
G1 X110.516 Y101.235 E.01598
G1 X102.935 Y108.816 E.32025
G1 X102.935 Y108.281 E.01598
G1 X109.981 Y101.235 E.29766
G1 X109.446 Y101.235 E.01598
G1 X102.935 Y107.747 E.27506
G1 X102.935 Y107.212 E.01598
G1 X108.912 Y101.235 E.25247
G1 X108.377 Y101.235 E.01598
G1 X102.935 Y106.677 E.22988
G1 X102.935 Y106.142 E.01598
G1 X107.842 Y101.235 E.20729
G1 X107.307 Y101.235 E.01598
G1 X102.935 Y105.607 E.18469
G1 X102.935 Y105.073 E.01598
G1 X106.772 Y101.235 E.1621
G1 X106.238 Y101.235 E.01598
G1 X102.935 Y104.538 E.13951
G1 X102.935 Y104.003 E.01598
G1 X105.703 Y101.235 E.11692
G1 X105.168 Y101.235 E.01598
G1 X102.935 Y103.468 E.09432
G1 X102.935 Y102.933 E.01598
G1 X104.633 Y101.235 E.07173
G1 X104.099 Y101.235 E.01598
G1 X102.935 Y102.399 E.04914
G3 X103.218 Y101.581 I1.187 J-.047 E.02643
G1 X103.69 Y101.109 E.01996
; WIPE_START
G1 X103.218 Y101.581 E-.25394
G1 X103.121 Y101.703 E-.05901
G1 X103.009 Y101.919 E-.09241
G1 X102.95 Y102.135 E-.08533
G1 X102.935 Y102.399 E-.10015
G1 X103.25 Y102.084 E-.16915
; WIPE_END
G1 E-.04 F1800
G1 X110.863 Y102.625 Z.8 F30000
G1 X114.734 Y102.9 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X110.535 Y107.099 E.17739
G1 X110.535 Y107.634 E.01598
G1 X114.565 Y103.604 E.17022
G1 X114.565 Y104.139 E.01598
G1 X111.039 Y107.665 E.14894
G1 X111.574 Y107.665 E.01598
G1 X114.565 Y104.674 E.12634
G1 X114.565 Y105.209 E.01598
G1 X112.109 Y107.665 E.10375
G1 X112.644 Y107.665 E.01598
G1 X114.565 Y105.744 E.08116
G1 X114.565 Y106.278 E.01598
G1 X112.935 Y107.908 E.06883
G1 X112.935 Y108.443 E.01598
G1 X114.565 Y106.813 E.06883
G1 X114.565 Y107.348 E.01598
G1 X112.935 Y108.977 E.06883
G1 X112.935 Y109.512 E.01598
G1 X114.565 Y107.883 E.06883
G1 X114.565 Y108.418 E.01598
G1 X112.766 Y110.217 E.076
; WIPE_START
G1 X114.18 Y108.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.366 Y111.012 Z.8 F30000
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X110.642 Y110.735 E.0117
G1 X111.177 Y110.735 E.01598
G1 X110.535 Y111.377 E.02712
G1 X110.535 Y111.912 E.01598
G1 X111.712 Y110.735 E.04971
G1 X112.247 Y110.735 E.01598
G1 X110.366 Y112.617 E.07947
; WIPE_START
G1 X111.78 Y111.202 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.126 Y107.834 Z.8 F30000
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X107.465 Y107.496 E.01431
G1 X107.465 Y106.961 E.01598
G1 X106.761 Y107.665 E.02974
G1 X106.226 Y107.665 E.01598
G1 X107.465 Y106.426 E.05233
G1 X107.465 Y105.891 E.01598
G1 X105.521 Y107.834 E.08209
G1 X105.234 Y108.121 F30000
G1 F15000
G1 X102.935 Y110.421 E.09712
G1 X102.935 Y110.955 E.01598
G1 X105.065 Y108.826 E.08995
G1 X105.065 Y109.361 E.01598
G1 X102.935 Y111.49 E.08995
G1 X102.935 Y112.025 E.01598
G1 X105.065 Y109.896 E.08995
G1 X105.065 Y110.43 E.01598
G1 X102.935 Y112.56 E.08995
G1 X102.935 Y113.095 E.01598
G1 X105.295 Y110.735 E.09967
G1 X105.829 Y110.735 E.01598
G1 X102.935 Y113.629 E.12226
G1 X102.935 Y114.164 E.01598
G1 X106.364 Y110.735 E.14485
G1 X106.899 Y110.735 E.01598
G1 X102.935 Y114.699 E.16744
G1 X102.935 Y115.234 E.01598
G1 X107.434 Y110.735 E.19004
G1 X107.465 Y110.735 E.00092
G1 X107.465 Y111.239 E.01505
G1 X102.935 Y115.769 E.19134
G1 X102.935 Y116.303 E.01598
G1 X107.465 Y111.774 E.19134
G1 X107.465 Y112.309 E.01598
G1 X102.935 Y116.838 E.19134
G1 X102.935 Y117.373 E.01598
G1 X107.465 Y112.844 E.19134
G1 X107.465 Y113.135 E.00872
G1 X107.708 Y113.135 E.00726
G1 X102.935 Y117.908 E.20161
G1 X102.935 Y118.442 E.01598
G1 X108.243 Y113.135 E.2242
G1 X108.777 Y113.135 E.01598
G1 X102.935 Y118.977 E.2468
G1 X102.935 Y119.512 E.01598
G1 X109.312 Y113.135 E.26939
G1 X109.847 Y113.135 E.01598
G1 X102.935 Y120.047 E.29198
G1 X102.935 Y120.582 E.01598
G1 X114.565 Y108.952 E.49129
G1 X114.565 Y109.487 E.01598
G1 X102.935 Y121.116 E.49129
G1 X102.935 Y121.651 E.01598
G1 X114.565 Y110.022 E.49129
G1 X114.565 Y110.557 E.01598
G1 X102.935 Y122.186 E.49129
G1 X102.935 Y122.721 E.01598
G1 X114.565 Y111.092 E.49129
G1 X114.565 Y111.626 E.01598
G1 X102.935 Y123.256 E.49129
G1 X102.935 Y123.79 E.01598
G1 X114.565 Y112.161 E.49129
G1 X114.565 Y112.696 E.01598
G1 X102.935 Y124.325 E.49129
G1 X102.935 Y124.86 E.01598
G1 X114.565 Y113.231 E.49129
G1 X114.565 Y113.766 E.01598
G1 X102.935 Y125.395 E.49129
G1 X102.935 Y125.93 E.01598
G1 X114.565 Y114.3 E.49129
G1 X114.565 Y114.835 E.01598
G1 X102.935 Y126.464 E.49128
G1 X102.935 Y126.999 E.01598
G1 X114.565 Y115.37 E.49129
G1 X114.565 Y115.905 E.01598
G1 X102.935 Y127.534 E.49129
G1 X102.935 Y128.069 E.01598
G1 X114.869 Y116.135 E.50414
G1 X115.404 Y116.135 E.01598
G1 X102.935 Y128.604 E.52673
G1 X102.935 Y129.138 E.01598
G1 X115.938 Y116.135 E.54932
G1 X116.473 Y116.135 E.01598
G1 X102.935 Y129.673 E.57191
G1 X102.935 Y130.208 E.01598
G1 X117.008 Y116.135 E.59451
G1 X117.543 Y116.135 E.01598
G1 X102.935 Y130.743 E.6171
G1 X102.935 Y131.278 E.01598
G1 X118.078 Y116.135 E.63969
G1 X118.612 Y116.135 E.01598
G1 X102.935 Y131.812 E.66229
G1 X102.935 Y132.347 E.01598
G1 X119.147 Y116.135 E.68488
G1 X119.682 Y116.135 E.01598
G1 X114.725 Y121.092 E.2094
G3 X115.262 Y121.09 I.275 J1.611 E.01612
G1 X120.217 Y116.135 E.2093
G1 X120.752 Y116.135 E.01598
G1 X115.688 Y121.199 E.21392
G3 X116.046 Y121.376 I-.288 J1.035 E.012
G1 X121.286 Y116.135 E.22138
G1 X121.821 Y116.135 E.01598
G1 X116.34 Y121.617 E.23156
G3 X116.589 Y121.902 I-.63 J.801 E.01139
G1 X122.356 Y116.135 E.24363
G1 X122.891 Y116.135 E.01598
G1 X116.774 Y122.252 E.25839
G3 X116.896 Y122.665 I-.844 J.474 E.01297
G1 X123.426 Y116.135 E.27583
G1 X123.96 Y116.135 E.01598
G1 X116.721 Y123.374 E.30582
; WIPE_START
G1 X118.136 Y121.96 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.304 Y122.513 Z.8 F30000
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X102.935 Y132.882 E.43804
G1 X102.935 Y133.417 E.01598
G1 X113.09 Y123.262 E.42898
G1 X113.148 Y123.571 E.00939
G1 X113.199 Y123.688 E.0038
G1 X102.935 Y133.952 E.4336
G1 X102.935 Y134.486 E.01598
G1 X113.376 Y124.046 E.44106
G2 X113.617 Y124.34 I.897 J-.49 E.01142
G1 X102.935 Y135.021 E.45124
G1 X102.935 Y135.556 E.01598
G1 X113.902 Y124.589 E.4633
G2 X114.252 Y124.774 I.665 J-.831 E.01188
G1 X102.935 Y136.091 E.47806
G1 X102.935 Y136.626 E.01598
G1 X114.665 Y124.896 E.49551
G2 X115.151 Y124.931 I.335 J-1.268 E.01466
G1 X115.168 Y124.928 E.0005
G1 X102.935 Y137.16 E.51676
G1 X102.935 Y137.695 E.01598
G1 X124.495 Y116.135 E.91081
G1 X125.03 Y116.135 E.01598
G1 X102.935 Y138.23 E.9334
G1 X102.935 Y138.765 E.01598
G1 X125.565 Y116.135 E.95599
G1 X126.1 Y116.135 E.01598
G1 X102.935 Y139.3 E.97858
G1 X102.935 Y139.834 E.01598
G1 X126.634 Y116.135 E1.00118
G1 X127.169 Y116.135 E.01598
G1 X102.766 Y140.539 E1.03094
; WIPE_START
G1 X104.18 Y139.125 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P22 R12
G1 X103.404 Y146.718 Z.8 F30000
G1 X103.023 Y150.442 Z.8
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X112.13 Y141.335 E.38473
G1 X111.596 Y141.335 E.01598
G1 X102.971 Y149.96 E.36434
G1 X102.964 Y149.938 E.00068
G3 X102.935 Y149.461 I2.2 J-.373 E.01431
G1 X111.061 Y141.335 E.34326
G1 X110.526 Y141.335 E.01598
G1 X102.935 Y148.926 E.32067
G1 X102.935 Y148.391 E.01598
G1 X109.991 Y141.335 E.29808
G1 X109.456 Y141.335 E.01598
G1 X102.935 Y147.856 E.27549
G1 X102.935 Y147.322 E.01598
G1 X108.922 Y141.335 E.25289
G1 X108.387 Y141.335 E.01598
G1 X102.935 Y146.787 E.2303
G1 X102.935 Y146.252 E.01598
G1 X107.852 Y141.335 E.20771
G1 X107.317 Y141.335 E.01598
G1 X102.935 Y145.717 E.18512
G1 X102.935 Y145.182 E.01598
G1 X106.782 Y141.335 E.16252
G1 X106.248 Y141.335 E.01598
G1 X102.935 Y144.648 E.13993
G1 X102.935 Y144.113 E.01598
G1 X105.713 Y141.335 E.11734
G1 X105.178 Y141.335 E.01598
G1 X102.935 Y143.578 E.09474
G1 X102.935 Y143.043 E.01598
G1 X105.065 Y140.914 E.08995
G1 X105.065 Y140.379 E.01598
G1 X102.935 Y142.508 E.08995
G1 X102.935 Y141.974 E.01598
G1 X105.065 Y139.844 E.08995
G1 X105.065 Y139.31 E.01598
G1 X102.935 Y141.439 E.08995
G1 X102.935 Y140.904 E.01598
G1 X105.065 Y138.775 E.08995
G1 X105.065 Y138.265 E.01524
G1 X105.575 Y138.265 E.01524
G1 X127.704 Y116.135 E.93486
G1 X128.239 Y116.135 E.01598
G1 X106.109 Y138.265 E.93486
G1 X106.644 Y138.265 E.01598
G1 X128.774 Y116.135 E.93486
G1 X129.308 Y116.135 E.01598
G1 X107.179 Y138.265 E.93486
G1 X107.714 Y138.265 E.01598
G1 X129.843 Y116.135 E.93486
G1 X130.378 Y116.135 E.01598
G1 X108.249 Y138.265 E.93486
G1 X108.783 Y138.265 E.01598
G1 X131.083 Y115.966 E.94203
; WIPE_START
G1 X129.668 Y117.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.266 Y115.922 Z.8 F30000
G1 Z.4
G1 E.8 F1800
G1 F15000
G1 X138.152 Y111.035 E.20643
G1 X137.617 Y111.035 E.01598
G1 X133.435 Y115.217 E.17667
G1 X133.435 Y114.682 E.01598
G1 X137.082 Y111.035 E.15407
G1 X136.548 Y111.035 E.01598
G1 X133.435 Y114.148 E.13148
G1 X133.435 Y113.613 E.01598
G1 X136.013 Y111.035 E.10889
G1 X135.478 Y111.035 E.01598
G1 X133.249 Y113.265 E.09418
G1 X132.714 Y113.265 E.01598
G1 X134.943 Y111.035 E.09418
G1 X134.408 Y111.035 E.01598
G1 X132.179 Y113.265 E.09418
G1 X131.644 Y113.265 E.01598
G1 X133.874 Y111.035 E.09418
G1 X133.339 Y111.035 E.01598
G1 X131.11 Y113.265 E.09418
G1 X130.575 Y113.265 E.01598
G1 X132.804 Y111.035 E.09418
G1 X132.269 Y111.035 E.01598
G1 X130.04 Y113.265 E.09418
G1 X129.505 Y113.265 E.01598
G1 X131.734 Y111.035 E.09418
G1 X131.2 Y111.035 E.01598
G1 X128.97 Y113.265 E.09418
G1 X128.436 Y113.265 E.01598
G1 X130.665 Y111.035 E.09418
G1 X130.13 Y111.035 E.01598
G1 X127.901 Y113.265 E.09418
G1 X127.366 Y113.265 E.01598
G1 X129.595 Y111.035 E.09418
G1 X129.06 Y111.035 E.01598
G1 X126.831 Y113.265 E.09418
G1 X126.296 Y113.265 E.01598
G1 X128.526 Y111.035 E.09418
G1 X127.991 Y111.035 E.01598
G1 X125.762 Y113.265 E.09418
G1 X125.227 Y113.265 E.01598
G1 X127.456 Y111.035 E.09418
G1 X126.921 Y111.035 E.01598
G1 X124.692 Y113.265 E.09418
G1 X124.157 Y113.265 E.01598
G1 X126.386 Y111.035 E.09418
G1 X125.852 Y111.035 E.01598
G1 X123.622 Y113.265 E.09418
G1 X123.088 Y113.265 E.01598
G1 X125.317 Y111.035 E.09418
G1 X124.782 Y111.035 E.01598
G1 X122.553 Y113.265 E.09418
G1 X122.018 Y113.265 E.01598
G1 X124.247 Y111.035 E.09418
G1 X123.712 Y111.035 E.01598
G1 X121.483 Y113.265 E.09418
G1 X120.948 Y113.265 E.01598
G1 X123.178 Y111.035 E.09418
G1 X122.643 Y111.035 E.01598
G1 X120.414 Y113.265 E.09418
G1 X119.879 Y113.265 E.01598
G1 X122.108 Y111.035 E.09418
G1 X121.573 Y111.035 E.01598
G1 X119.344 Y113.265 E.09418
G1 X118.935 Y113.265 E.01221
G1 X118.935 Y113.138 E.00377
G1 X121.038 Y111.035 E.08885
G1 X120.504 Y111.035 E.01598
G1 X118.935 Y112.604 E.06626
G1 X118.935 Y112.069 E.01598
G1 X119.969 Y111.035 E.04366
G1 X119.549 Y111.035 E.01254
G1 X119.549 Y111.239 E.00608
G1 X119.231 Y111.239 E.00952
G1 X118.766 Y111.704 E.01964
G1 X119 Y110.905 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y107.494 E.10476
; WIPE_START
G1 X119 Y109.494 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.766 Y105.821 Z.8 F30000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42108
G1 F15000
G1 X119.451 Y105.135 E.02897
G1 X119.986 Y105.135 E.01598
G1 X118.935 Y106.186 E.04439
G1 X118.935 Y106.721 E.01598
G1 X120.521 Y105.135 E.06698
G1 X121.056 Y105.135 E.01598
G1 X119.03 Y107.161 E.08559
G1 X119.549 Y107.161 E.01552
G1 X119.549 Y107.177 E.00046
G1 X121.59 Y105.135 E.08623
G1 X122.125 Y105.135 E.01598
G1 X119.896 Y107.365 E.09418
G1 X120.431 Y107.365 E.01598
G1 X122.66 Y105.135 E.09418
G1 X123.195 Y105.135 E.01598
G1 X120.966 Y107.365 E.09418
G1 X121.5 Y107.365 E.01598
G1 X123.73 Y105.135 E.09418
G1 X124.264 Y105.135 E.01598
G1 X122.035 Y107.365 E.09418
G1 X122.57 Y107.365 E.01598
G1 X124.799 Y105.135 E.09418
G1 X125.334 Y105.135 E.01598
G1 X123.105 Y107.365 E.09418
G1 X123.64 Y107.365 E.01598
G1 X125.869 Y105.135 E.09418
G1 X126.404 Y105.135 E.01598
G1 X124.174 Y107.365 E.09418
G1 X124.709 Y107.365 E.01598
G1 X126.938 Y105.135 E.09418
G1 X127.473 Y105.135 E.01598
G1 X125.244 Y107.365 E.09418
G1 X125.779 Y107.365 E.01598
G1 X128.008 Y105.135 E.09418
G1 X128.543 Y105.135 E.01598
G1 X126.314 Y107.365 E.09418
G1 X126.848 Y107.365 E.01598
G1 X129.078 Y105.135 E.09418
G1 X129.612 Y105.135 E.01598
G1 X127.383 Y107.365 E.09418
G1 X127.918 Y107.365 E.01598
G1 X130.147 Y105.135 E.09418
G1 X130.682 Y105.135 E.01598
G1 X128.453 Y107.365 E.09418
G1 X128.988 Y107.365 E.01598
G1 X131.217 Y105.135 E.09418
G1 X131.752 Y105.135 E.01598
G1 X129.522 Y107.365 E.09418
G1 X130.057 Y107.365 E.01598
G1 X132.286 Y105.135 E.09418
G1 X132.821 Y105.135 E.01598
G1 X130.592 Y107.365 E.09418
G1 X131.127 Y107.365 E.01598
G1 X137.256 Y101.236 E.25891
G1 X137.79 Y101.236 E.01598
G1 X131.662 Y107.365 E.25891
G1 X132.196 Y107.365 E.01598
G1 X138.325 Y101.236 E.25891
G1 X138.86 Y101.236 E.01598
G1 X132.731 Y107.365 E.25891
G1 X133.266 Y107.365 E.01598
G1 X139.395 Y101.236 E.25891
G1 X139.929 Y101.236 E.01598
G1 X133.801 Y107.365 E.25891
G1 X134.336 Y107.365 E.01598
G1 X140.464 Y101.236 E.25891
G1 X140.999 Y101.236 E.01598
G1 X134.87 Y107.365 E.25891
G1 X135.405 Y107.365 E.01598
G1 X141.534 Y101.236 E.25891
G1 X142.069 Y101.236 E.01598
G1 X135.94 Y107.365 E.25891
G1 X136.475 Y107.365 E.01598
G1 X142.603 Y101.236 E.25891
G1 X143.138 Y101.236 E.01598
G1 X137.01 Y107.365 E.25891
G1 X137.544 Y107.365 E.01598
G1 X143.673 Y101.236 E.25891
G1 X144.208 Y101.236 E.01598
G1 X138.079 Y107.365 E.25891
G1 X138.614 Y107.365 E.01598
G1 X144.743 Y101.236 E.25891
G1 X145.277 Y101.236 E.01598
G1 X139.149 Y107.365 E.25891
G1 X139.684 Y107.365 E.01598
G1 X145.812 Y101.236 E.25891
G1 X146.347 Y101.236 E.01598
G1 X140.218 Y107.365 E.25891
G1 X140.753 Y107.365 E.01598
G1 X146.882 Y101.236 E.25891
G1 X147.417 Y101.236 E.01598
G1 X141.288 Y107.365 E.25891
G1 X141.823 Y107.365 E.01598
G1 X147.951 Y101.236 E.25891
G1 X148.486 Y101.236 E.01598
G1 X142.358 Y107.365 E.25891
G1 X142.892 Y107.365 E.01598
G1 X149.021 Y101.236 E.25891
G1 X149.556 Y101.236 E.01598
G1 X143.427 Y107.365 E.2589
G1 X143.962 Y107.365 E.01598
G1 X150.091 Y101.236 E.2589
G1 X150.625 Y101.236 E.01598
G1 X144.497 Y107.365 E.2589
G1 X145.031 Y107.365 E.01598
G1 X151.16 Y101.236 E.2589
G1 X151.695 Y101.236 E.01598
G1 X145.566 Y107.365 E.2589
G1 X146.101 Y107.365 E.01598
G1 X152.205 Y101.261 E.25787
G3 X152.585 Y101.416 I-.474 J1.704 E.01228
G1 X146.636 Y107.365 E.25132
G1 X147.171 Y107.365 E.01598
G1 X152.858 Y101.677 E.24028
G3 X153.029 Y102.041 I-.883 J.635 E.01208
G1 X147.705 Y107.365 E.22489
G1 X148.24 Y107.365 E.01598
G1 X153.065 Y102.54 E.20381
G1 X153.065 Y103.075 E.01598
G1 X148.775 Y107.365 E.18121
G1 X149.31 Y107.365 E.01598
G1 X153.065 Y103.61 E.15862
G1 X153.065 Y104.145 E.01598
G1 X149.845 Y107.365 E.13603
G1 X150.379 Y107.365 E.01598
G1 X153.065 Y104.679 E.11344
G1 X153.065 Y105.214 E.01598
G1 X150.914 Y107.365 E.09084
G1 X151.449 Y107.365 E.01598
G1 X153.065 Y105.749 E.06825
G1 X153.065 Y106.284 E.01598
G1 X151.984 Y107.365 E.04566
G1 X152.519 Y107.365 E.01598
G1 X153.065 Y106.819 E.02307
G1 X153.065 Y107.353 E.01598
G1 X152.884 Y107.534 E.00764
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X153.065 Y107.353 E-.0972
G1 X153.065 Y106.819 E-.20322
G1 X152.519 Y107.365 E-.29341
G1 X152.081 Y107.365 E-.16617
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 3/22
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
G17
G3 Z.8 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.64 Y122.161
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.828 Y121.911 E.01005
G3 X127.885 Y121.402 I1.175 J1.089 E.03864
G1 X128 Y121.398 E.00369
G3 X126.608 Y122.211 I.002 J1.602 E.26931
M204 S250
G1 X126.954 Y122.392 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X127.114 Y122.178 E.00799
G3 X127.914 Y121.793 I.888 J.822 E.02706
G1 X128 Y121.79 E.00257
G3 X126.927 Y122.445 I.002 J1.21 E.187
; WIPE_START
M204 S10000
G1 X127.114 Y122.178 E-.12422
G1 X127.318 Y122 E-.10273
G1 X127.475 Y121.91 E-.06876
G1 X127.731 Y121.82 E-.10298
G1 X127.914 Y121.793 E-.07035
G1 X128 Y121.79 E-.03277
G1 X128.18 Y121.803 E-.06874
G1 X128.442 Y121.874 E-.10299
G1 X128.605 Y121.952 E-.06881
G1 X128.643 Y121.98 E-.01765
; WIPE_END
G1 E-.04 F1800
G1 X121.018 Y122.331 Z1 F30000
G1 X116.525 Y122.537 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.564 Y122.643 E.00362
G3 X114.885 Y121.402 I-1.562 J.356 E.25053
G1 X115 Y121.398 E.00369
G3 X116.445 Y122.303 I.002 J1.602 E.05782
G1 X116.506 Y122.481 E.00604
M204 S250
G1 X116.157 Y122.666 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.181 Y122.73 E.00204
M73 P23 R12
G3 X114.914 Y121.793 I-1.179 J.269 E.17526
G1 X115 Y121.79 E.00257
G3 X116.092 Y122.474 I.002 J1.21 E.04046
G1 X116.138 Y122.609 E.00427
; WIPE_START
M204 S10000
G1 X116.181 Y122.73 E-.04879
G1 X116.207 Y122.91 E-.06886
G1 X116.197 Y123.18 E-.10288
G1 X116.156 Y123.357 E-.06881
G1 X116.048 Y123.605 E-.10306
G1 X115.89 Y123.82 E-.10122
G1 X115.755 Y123.946 E-.07036
G1 X115.525 Y124.09 E-.10297
G1 X115.294 Y124.171 E-.09305
; WIPE_END
G1 E-.04 F1800
G1 X116.1 Y131.761 Z1 F30000
G1 X117.656 Y146.402 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.08868
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y135.402 E.07088
G1 X118.602 Y135.402 E.46627
G1 X118.602 Y144.198 E.28284
G1 X133.102 Y144.198 E.46627
G1 X133.102 Y146.402 E.07088
G1 X117.716 Y146.402 E.49477
; WIPE_START
G1 X115.716 Y146.402 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y144.59 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y144.59 E.43191
G1 X132.71 Y146.01 E.0423
G1 X115.29 Y146.01 E.51888
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y135.01 E.0423
G1 X118.21 Y135.01 E.43191
G1 X118.21 Y144.53 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y144.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.153 Y141.631 Z1 F30000
G1 X105.79 Y138.598 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.381 Y131.422 Z1 F30000
G1 X110.202 Y107.998 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.532 Y114.376 Z1 F30000
G1 X117.656 Y115.802 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.08867
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y104.802 E.07088
G1 X118.602 Y104.802 E.46627
G1 X118.602 Y113.598 E.28284
G1 X133.102 Y113.598 E.46627
G1 X133.102 Y115.802 E.07088
G1 X117.716 Y115.802 E.49478
; WIPE_START
G1 X115.716 Y115.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y113.99 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y113.99 E.43191
G1 X132.71 Y115.41 E.0423
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y104.41 E.0423
G1 X118.21 Y104.41 E.43191
G1 X118.21 Y113.93 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y113.938 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.331 Y116.686 Z1 F30000
G1 X142.529 Y122.549 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.564 Y122.643 E.00322
G3 X140.885 Y121.402 I-1.562 J.356 E.25053
G1 X141 Y121.398 E.00369
G3 X142.445 Y122.303 I.002 J1.602 E.05782
G1 X142.51 Y122.492 E.00644
M204 S250
G1 X142.161 Y122.678 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.181 Y122.73 E.00167
G3 X140.914 Y121.793 I-1.179 J.269 E.17526
G1 X141 Y121.79 E.00257
G3 X142.092 Y122.474 I.002 J1.21 E.04046
G1 X142.142 Y122.621 E.00464
; WIPE_START
M204 S10000
G1 X142.181 Y122.73 E-.04404
G1 X142.207 Y122.91 E-.06886
G1 X142.197 Y123.18 E-.10288
G1 X142.156 Y123.357 E-.06881
G1 X142.048 Y123.605 E-.10306
G1 X141.89 Y123.82 E-.10122
G1 X141.755 Y123.946 E-.07036
G1 X141.525 Y124.09 E-.10297
G1 X141.282 Y124.175 E-.09781
; WIPE_END
G1 E-.04 F1800
G1 X134.869 Y128.314 Z1 F30000
G1 X119.398 Y138.298 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X119.398 Y141.302 E.0966
G1 X153.398 Y141.302 E1.09332
G1 X153.398 Y149.689 E.26969
G3 X151.985 Y151.098 I-1.402 J.007 E.07141
G1 X104.011 Y151.098 E1.54264
G3 X102.602 Y149.685 I-.009 J-1.401 E.07142
G1 X102.602 Y102.311 E1.52338
G3 X104.015 Y100.902 I1.402 J-.007 E.07141
G1 X152.025 Y100.903 E1.5438
G3 X153.398 Y102.311 I-.027 J1.4 E.07012
G1 X153.398 Y107.698 E.17322
M73 P23 R11
G1 X119.398 Y107.698 E1.09332
G1 X119.398 Y110.702 E.0966
G1 X153.398 Y110.702 E1.09332
G1 X153.398 Y138.298 E.88738
G1 X119.458 Y138.298 E1.09139
M204 S250
G1 X119.79 Y138.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X119.79 Y140.91 E.06613
G1 X153.79 Y140.91 E1.01274
G1 X153.79 Y149.696 E.26171
G3 X151.995 Y151.49 I-1.794 J0 E.08398
G1 X104.004 Y151.49 E1.42947
G3 X102.21 Y149.695 I-.001 J-1.793 E.08399
G1 X102.21 Y102.304 E1.41162
G3 X104.005 Y100.51 I1.794 J0 E.08398
G1 X152.032 Y100.511 E1.43055
G3 X153.79 Y102.304 I-.034 J1.792 E.08286
G1 X153.79 Y108.09 E.17235
G1 X119.79 Y108.09 E1.01274
G1 X119.79 Y110.31 E.06613
G1 X153.79 Y110.31 E1.01274
G1 X153.79 Y138.69 E.84534
G1 X119.85 Y138.69 E1.01096
; WIPE_START
M204 S10000
G1 X119.796 Y140.689 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P24 R11
G1 X119 Y138.095 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y141.506 E.10476
; WIPE_START
G1 X119 Y139.506 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.295 Y144.034 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42108
G1 F15000
G1 X118.935 Y143.674 E.01522
G1 X118.935 Y143.139 E.01598
G1 X119.661 Y143.865 E.03064
G1 X120.195 Y143.865 E.01598
G1 X118.935 Y142.605 E.05323
G1 X118.935 Y142.07 E.01598
G1 X120.73 Y143.865 E.07583
G1 X121.265 Y143.865 E.01598
G1 X119.239 Y141.839 E.08559
G1 X119.549 Y141.839 E.00926
G1 X119.549 Y141.635 E.00608
G1 X119.57 Y141.635 E.00064
G1 X121.8 Y143.865 E.09418
G1 X122.335 Y143.865 E.01598
G1 X120.105 Y141.635 E.09418
G1 X120.64 Y141.635 E.01598
G1 X122.869 Y143.865 E.09418
G1 X123.404 Y143.865 E.01598
G1 X121.175 Y141.635 E.09418
G1 X121.71 Y141.635 E.01598
G1 X123.939 Y143.865 E.09418
G1 X124.474 Y143.865 E.01598
G1 X122.244 Y141.635 E.09418
G1 X122.779 Y141.635 E.01598
G1 X125.009 Y143.865 E.09418
G1 X125.543 Y143.865 E.01598
G1 X123.314 Y141.635 E.09418
G1 X123.849 Y141.635 E.01598
G1 X126.078 Y143.865 E.09418
G1 X126.613 Y143.865 E.01598
G1 X124.384 Y141.635 E.09418
G1 X124.918 Y141.635 E.01598
G1 X127.148 Y143.865 E.09418
G1 X127.683 Y143.865 E.01598
G1 X125.453 Y141.635 E.09418
G1 X125.988 Y141.635 E.01598
G1 X128.217 Y143.865 E.09418
G1 X128.752 Y143.865 E.01598
G1 X126.523 Y141.635 E.09418
G1 X127.058 Y141.635 E.01598
G1 X129.287 Y143.865 E.09418
G1 X129.822 Y143.865 E.01598
G1 X127.592 Y141.635 E.09418
G1 X128.127 Y141.635 E.01598
G1 X130.357 Y143.865 E.09418
G1 X130.891 Y143.865 E.01598
G1 X128.662 Y141.635 E.09418
G1 X129.197 Y141.635 E.01598
G1 X131.426 Y143.865 E.09418
G1 X131.961 Y143.865 E.01598
G1 X129.732 Y141.635 E.09418
G1 X130.266 Y141.635 E.01598
G1 X132.496 Y143.865 E.09418
G1 X133.031 Y143.865 E.01598
G1 X130.801 Y141.635 E.09418
G1 X131.336 Y141.635 E.01598
G1 X140.465 Y150.765 E.38567
G1 X141 Y150.765 E.01598
G1 X131.871 Y141.635 E.38567
G1 X132.406 Y141.635 E.01598
G1 X141.535 Y150.765 E.38567
G1 X142.07 Y150.765 E.01598
G1 X132.94 Y141.635 E.38567
G1 X133.475 Y141.635 E.01598
G1 X142.605 Y150.765 E.38567
G1 X143.139 Y150.765 E.01598
G1 X134.01 Y141.635 E.38567
G1 X134.545 Y141.635 E.01598
G1 X143.674 Y150.765 E.38567
G1 X144.209 Y150.765 E.01598
G1 X135.08 Y141.635 E.38567
G1 X135.614 Y141.635 E.01598
G1 X144.744 Y150.765 E.38567
G1 X145.279 Y150.765 E.01598
G1 X136.149 Y141.635 E.38567
G1 X136.684 Y141.635 E.01598
G1 X145.813 Y150.765 E.38567
G1 X146.348 Y150.765 E.01598
G1 X137.219 Y141.635 E.38567
G1 X137.754 Y141.635 E.01598
G1 X146.883 Y150.765 E.38567
G1 X147.418 Y150.765 E.01598
G1 X138.288 Y141.635 E.38567
G1 X138.823 Y141.635 E.01598
G1 X147.953 Y150.765 E.38567
G1 X148.487 Y150.765 E.01598
G1 X139.358 Y141.635 E.38567
G1 X139.893 Y141.635 E.01598
G1 X149.022 Y150.765 E.38567
G1 X149.557 Y150.765 E.01598
G1 X140.428 Y141.635 E.38567
G1 X140.962 Y141.635 E.01598
G1 X150.092 Y150.765 E.38567
G1 X150.627 Y150.765 E.01598
G1 X141.497 Y141.635 E.38567
G1 X142.032 Y141.635 E.01598
G1 X151.161 Y150.765 E.38567
G1 X151.696 Y150.765 E.01598
G1 X142.567 Y141.635 E.38567
G1 X143.102 Y141.635 E.01598
G1 X152.205 Y150.739 E.38459
G2 X152.586 Y150.585 I-.223 J-1.103 E.01234
G1 X143.636 Y141.635 E.37809
G1 X144.171 Y141.635 E.01598
G1 X152.859 Y150.324 E.36704
G2 X153.03 Y149.959 I-1.076 J-.724 E.01207
G1 X144.706 Y141.635 E.35163
G1 X145.241 Y141.635 E.01598
G1 X153.061 Y149.455 E.33035
G1 X153.061 Y148.921 E.01597
G1 X145.776 Y141.635 E.30777
G1 X146.31 Y141.635 E.01598
G1 X153.061 Y148.386 E.28519
G1 X153.061 Y147.852 E.01597
G1 X146.845 Y141.635 E.26261
G1 X147.38 Y141.635 E.01598
G1 X153.062 Y147.317 E.24003
G1 X153.062 Y146.783 E.01597
G1 X147.915 Y141.635 E.21744
G1 X148.45 Y141.635 E.01598
G1 X153.062 Y146.248 E.19486
G1 X153.063 Y145.713 E.01597
G1 X148.984 Y141.635 E.17228
G1 X149.519 Y141.635 E.01598
G1 X153.063 Y145.179 E.1497
G1 X153.063 Y144.644 E.01597
G1 X150.054 Y141.635 E.12712
G1 X150.589 Y141.635 E.01598
G1 X153.063 Y144.11 E.10454
G1 X153.064 Y143.575 E.01597
G1 X151.124 Y141.635 E.08195
G1 X151.658 Y141.635 E.01598
G1 X153.064 Y143.041 E.05937
G1 X153.064 Y142.506 E.01597
G1 X152.193 Y141.635 E.03679
G1 X152.728 Y141.635 E.01598
G1 X153.234 Y142.141 E.02137
; WIPE_START
G1 X152.728 Y141.635 E-.27189
G1 X152.193 Y141.635 E-.20322
G1 X152.723 Y142.165 E-.28488
; WIPE_END
G1 E-.04 F1800
G1 X153.234 Y137.863 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X131.506 Y116.135 E.9179
G1 X130.972 Y116.135 E.01598
G1 X152.801 Y137.965 E.92219
G1 X152.266 Y137.965 E.01598
G1 X130.437 Y116.135 E.92219
G1 X129.902 Y116.135 E.01598
G1 X151.731 Y137.965 E.92219
G1 X151.197 Y137.965 E.01598
G1 X129.367 Y116.135 E.92219
G1 X128.832 Y116.135 E.01598
G1 X150.662 Y137.965 E.92219
G1 X150.127 Y137.965 E.01598
G1 X128.298 Y116.135 E.92219
G1 X127.763 Y116.135 E.01598
G1 X149.592 Y137.965 E.92219
G1 X149.057 Y137.965 E.01598
G1 X127.228 Y116.135 E.92219
G1 X126.693 Y116.135 E.01598
G1 X148.523 Y137.965 E.92219
G1 X147.988 Y137.965 E.01598
G1 X126.158 Y116.135 E.92219
G1 X125.624 Y116.135 E.01598
G1 X147.453 Y137.965 E.92219
G1 X146.918 Y137.965 E.01598
G1 X125.089 Y116.135 E.92219
G1 X124.554 Y116.135 E.01598
G1 X146.383 Y137.965 E.92219
G1 X145.849 Y137.965 E.01598
G1 X124.019 Y116.135 E.92219
G1 X123.484 Y116.135 E.01598
G1 X128.477 Y121.128 E.21091
G1 X128.283 Y121.084 E.00595
G1 X127.882 Y121.068 E.01197
G1 X122.95 Y116.135 E.20839
G1 X122.415 Y116.135 E.01598
G1 X127.436 Y121.157 E.21214
G2 X127.058 Y121.314 I.225 J1.077 E.0123
G1 X121.88 Y116.135 E.21876
G1 X121.345 Y116.135 E.01598
G1 X126.747 Y121.537 E.22821
G2 X126.485 Y121.81 I.466 J.711 E.01139
G1 X120.81 Y116.135 E.23972
G1 X120.276 Y116.135 E.01598
G1 X126.274 Y122.133 E.25339
G2 X126.133 Y122.528 I.968 J.568 E.01257
G1 X119.741 Y116.135 E.27004
G1 X119.206 Y116.135 E.01598
G1 X126.073 Y123.002 E.29009
G2 X126.188 Y123.652 I1.653 J.042 E.01985
G1 X118.671 Y116.135 E.31755
G1 X118.136 Y116.135 E.01598
G1 X139.966 Y137.965 E.92219
G1 X140.501 Y137.965 E.01598
G1 X127.356 Y124.82 E.55529
G2 X127.998 Y124.927 I.611 J-1.694 E.01953
G1 X141.035 Y137.965 E.55078
G1 X141.57 Y137.965 E.01598
G1 X128.475 Y124.87 E.55319
G2 X128.869 Y124.728 I-.52 J-2.064 E.01251
G1 X142.105 Y137.965 E.55917
G1 X142.64 Y137.965 E.01598
G1 X129.197 Y124.522 E.56789
G1 X129.467 Y124.257 E.0113
G1 X143.175 Y137.965 E.5791
G1 X143.709 Y137.965 E.01598
G1 X129.689 Y123.944 E.5923
G1 X129.851 Y123.571 E.01215
G1 X144.244 Y137.965 E.60806
G1 X144.779 Y137.965 E.01598
G1 X129.923 Y123.109 E.6276
G2 X129.874 Y122.525 I-1.889 J-.135 E.01757
G1 X145.483 Y138.134 E.65943
; WIPE_START
G1 X144.069 Y136.72 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.017 Y144.071 Z1 F30000
G1 X140.1 Y150.934 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
M73 P25 R11
G1 X133.435 Y144.269 E.28156
G1 X133.435 Y144.804 E.01598
G1 X139.396 Y150.765 E.2518
G1 X138.861 Y150.765 E.01598
G1 X133.435 Y145.339 E.22921
G1 X133.435 Y145.874 E.01598
G1 X138.326 Y150.765 E.20662
G1 X137.791 Y150.765 E.01598
G1 X133.435 Y146.409 E.18402
G1 X133.435 Y146.735 E.00976
G1 X133.227 Y146.735 E.00622
G1 X137.257 Y150.765 E.17022
G1 X136.722 Y150.765 E.01598
G1 X132.692 Y146.735 E.17022
G1 X132.158 Y146.735 E.01598
G1 X136.187 Y150.765 E.17022
G1 X135.652 Y150.765 E.01598
G1 X131.623 Y146.735 E.17022
G1 X131.088 Y146.735 E.01598
G1 X135.117 Y150.765 E.17022
G1 X134.583 Y150.765 E.01598
G1 X130.553 Y146.735 E.17022
G1 X130.018 Y146.735 E.01598
G1 X134.048 Y150.765 E.17022
G1 X133.513 Y150.765 E.01598
G1 X129.484 Y146.735 E.17022
G1 X128.949 Y146.735 E.01598
G1 X132.978 Y150.765 E.17022
G1 X132.443 Y150.765 E.01598
G1 X128.414 Y146.735 E.17022
G1 X127.879 Y146.735 E.01598
G1 X131.909 Y150.765 E.17022
G1 X131.374 Y150.765 E.01598
G1 X127.344 Y146.735 E.17022
G1 X126.81 Y146.735 E.01598
G1 X130.839 Y150.765 E.17022
G1 X130.304 Y150.765 E.01598
G1 X126.275 Y146.735 E.17022
G1 X125.74 Y146.735 E.01598
G1 X129.769 Y150.765 E.17022
G1 X129.235 Y150.765 E.01598
G1 X125.205 Y146.735 E.17022
G1 X124.67 Y146.735 E.01598
G1 X128.7 Y150.765 E.17022
G1 X128.165 Y150.765 E.01598
G1 X124.136 Y146.735 E.17022
G1 X123.601 Y146.735 E.01598
G1 X127.63 Y150.765 E.17022
G1 X127.095 Y150.765 E.01598
G1 X123.066 Y146.735 E.17022
G1 X122.531 Y146.735 E.01598
G1 X126.561 Y150.765 E.17022
G1 X126.026 Y150.765 E.01598
G1 X121.996 Y146.735 E.17022
G1 X121.462 Y146.735 E.01598
G1 X125.491 Y150.765 E.17022
G1 X124.956 Y150.765 E.01598
G1 X120.927 Y146.735 E.17022
G1 X120.392 Y146.735 E.01598
G1 X124.421 Y150.765 E.17022
G1 X123.887 Y150.765 E.01598
G1 X119.857 Y146.735 E.17022
G1 X119.322 Y146.735 E.01598
G1 X123.352 Y150.765 E.17022
G1 X122.817 Y150.765 E.01598
G1 X118.788 Y146.735 E.17022
G1 X118.253 Y146.735 E.01598
G1 X122.282 Y150.765 E.17022
G1 X121.747 Y150.765 E.01598
G1 X117.718 Y146.735 E.17022
G1 X117.183 Y146.735 E.01598
G1 X121.213 Y150.765 E.17022
G1 X120.678 Y150.765 E.01598
G1 X116.648 Y146.735 E.17022
G1 X116.114 Y146.735 E.01598
G1 X120.143 Y150.765 E.17022
G1 X119.608 Y150.765 E.01598
G1 X115.579 Y146.735 E.17022
G1 X115.044 Y146.735 E.01598
G1 X119.073 Y150.765 E.17022
G1 X118.539 Y150.765 E.01598
G1 X109.109 Y141.335 E.39835
G1 X109.644 Y141.335 E.01598
G1 X114.565 Y146.256 E.20787
G1 X114.565 Y145.721 E.01598
G1 X110.179 Y141.335 E.18528
G1 X110.714 Y141.335 E.01598
G1 X114.565 Y145.186 E.16269
G1 X114.565 Y144.652 E.01598
G1 X111.248 Y141.335 E.14009
G1 X111.783 Y141.335 E.01598
G1 X114.565 Y144.117 E.1175
G1 X114.565 Y143.582 E.01598
G1 X112.318 Y141.335 E.09491
G1 X112.853 Y141.335 E.01598
G1 X114.565 Y143.047 E.07232
G1 X114.565 Y142.512 E.01598
G1 X112.935 Y140.883 E.06883
G1 X112.935 Y140.348 E.01598
G1 X114.565 Y141.978 E.06883
G1 X114.565 Y141.443 E.01598
G1 X112.935 Y139.813 E.06883
G1 X112.935 Y139.279 E.01598
G1 X114.565 Y140.908 E.06883
G1 X114.565 Y140.373 E.01598
G1 X112.935 Y138.744 E.06883
G1 X112.935 Y138.265 E.01431
G1 X112.456 Y138.265 E.01431
G1 X102.935 Y128.744 E.40221
G1 X102.935 Y128.209 E.01598
G1 X114.565 Y139.838 E.49129
G1 X114.565 Y139.304 E.01598
G1 X102.935 Y127.674 E.49129
G1 X102.935 Y127.139 E.01598
G1 X114.565 Y138.769 E.49129
G1 X114.565 Y138.234 E.01598
G1 X102.935 Y126.605 E.49129
G1 X102.935 Y126.07 E.01598
G1 X114.565 Y137.699 E.49129
G1 X114.565 Y137.164 E.01598
G1 X102.935 Y125.535 E.49129
G1 X102.935 Y125 E.01598
G1 X114.565 Y136.63 E.49129
G1 X114.565 Y136.095 E.01598
G1 X102.935 Y124.465 E.49129
G1 X102.935 Y123.931 E.01598
G1 X114.565 Y135.56 E.49129
G1 X114.565 Y135.025 E.01598
G1 X102.935 Y123.396 E.49129
G1 X102.935 Y122.861 E.01598
G1 X114.565 Y134.49 E.49129
G1 X114.565 Y133.956 E.01598
G1 X102.935 Y122.326 E.49129
G1 X102.935 Y121.791 E.01598
G1 X114.565 Y133.421 E.49129
G1 X114.565 Y132.886 E.01598
G1 X102.935 Y121.257 E.49129
G1 X102.935 Y120.722 E.01598
G1 X115.078 Y132.865 E.51298
G1 X115.613 Y132.865 E.01598
G1 X102.935 Y120.187 E.53557
G1 X102.935 Y119.652 E.01598
G1 X116.148 Y132.865 E.55816
G1 X116.683 Y132.865 E.01598
G1 X102.935 Y119.117 E.58076
G1 X102.935 Y118.583 E.01598
G1 X117.217 Y132.865 E.60335
G1 X117.752 Y132.865 E.01598
G1 X102.935 Y118.048 E.62594
G1 X102.935 Y117.513 E.01598
G1 X118.287 Y132.865 E.64854
G1 X118.822 Y132.865 E.01598
G1 X102.935 Y116.978 E.67113
G1 X102.935 Y116.443 E.01598
G1 X119.357 Y132.865 E.69372
G1 X119.891 Y132.865 E.01598
G1 X102.935 Y115.909 E.71631
G1 X102.935 Y115.374 E.01598
G1 X120.426 Y132.865 E.73891
G1 X120.961 Y132.865 E.01598
G1 X102.935 Y114.839 E.7615
G1 X102.935 Y114.304 E.01598
G1 X121.496 Y132.865 E.78409
G1 X122.031 Y132.865 E.01598
G1 X102.766 Y113.6 E.81385
; WIPE_START
G1 X104.18 Y115.014 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.224 Y119.675 Z1 F30000
G1 X127.548 Y133.034 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X102.935 Y108.421 E1.03978
G1 X102.935 Y108.956 E.01598
G1 X115.054 Y121.075 E.51195
G2 X114.559 Y121.114 I-.065 J2.306 E.01487
G1 X102.935 Y109.491 E.49103
G1 X102.935 Y110.026 E.01598
G1 X114.163 Y121.253 E.47431
G2 X113.836 Y121.461 I.387 J.97 E.01164
G1 X102.935 Y110.561 E.4605
G1 X102.935 Y111.095 E.01598
G1 X113.555 Y121.715 E.44863
G1 X113.328 Y122.023 E.01142
G1 X102.935 Y111.63 E.43903
G1 X102.935 Y112.165 E.01598
G1 X113.168 Y122.398 E.43228
G1 X113.084 Y122.713 E.00974
G1 X113.079 Y122.843 E.00391
G1 X102.935 Y112.7 E.42851
G1 X102.935 Y113.235 E.01598
G1 X113.108 Y123.408 E.42976
G1 X113.113 Y123.437 E.00089
G2 X114.587 Y124.886 I1.875 J-.433 E.0652
G1 X122.565 Y132.865 E.33704
G1 X123.1 Y132.865 E.01598
G1 X115.164 Y124.929 E.33526
G1 X115.607 Y124.837 E.0135
G1 X123.635 Y132.865 E.33915
G1 X124.17 Y132.865 E.01598
G1 X115.97 Y124.665 E.34641
G2 X116.282 Y124.442 I-.333 J-.794 E.01155
G1 X124.705 Y132.865 E.35583
G1 X125.239 Y132.865 E.01598
G1 X116.542 Y124.167 E.36743
G2 X116.739 Y123.83 I-.791 J-.689 E.01175
G1 X125.774 Y132.865 E.38169
G1 X126.309 Y132.865 E.01598
G1 X116.881 Y123.437 E.39828
G2 X116.929 Y122.95 I-1.262 J-.37 E.01471
G1 X127.013 Y133.034 E.42602
; WIPE_START
G1 X125.599 Y131.62 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.86 Y138.744 Z1 F30000
G1 X118.174 Y150.934 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X108.574 Y141.335 E.40551
G1 X108.04 Y141.335 E.01598
G1 X117.469 Y150.765 E.39835
G1 X116.934 Y150.765 E.01598
G1 X107.505 Y141.335 E.39835
G1 X106.97 Y141.335 E.01598
G1 X116.399 Y150.765 E.39835
G1 X115.865 Y150.765 E.01598
G1 X106.435 Y141.335 E.39835
G1 X105.9 Y141.335 E.01598
G1 X115.33 Y150.765 E.39835
G1 X114.795 Y150.765 E.01598
G1 X102.935 Y138.905 E.50102
G1 X102.935 Y139.44 E.01598
G1 X114.26 Y150.765 E.47842
G1 X113.725 Y150.765 E.01598
G1 X102.935 Y139.975 E.45583
G1 X102.935 Y140.509 E.01598
G1 X113.191 Y150.765 E.43324
M73 P26 R11
G1 X112.656 Y150.765 E.01598
G1 X102.935 Y141.044 E.41065
G1 X102.935 Y141.579 E.01598
G1 X112.121 Y150.765 E.38805
G1 X111.586 Y150.765 E.01598
G1 X102.935 Y142.114 E.36546
G1 X102.935 Y142.649 E.01598
G1 X111.051 Y150.765 E.34287
G1 X110.517 Y150.765 E.01598
G1 X102.935 Y143.183 E.32028
G1 X102.935 Y143.718 E.01598
G1 X109.982 Y150.765 E.29768
G1 X109.447 Y150.765 E.01598
G1 X102.935 Y144.253 E.27509
G1 X102.935 Y144.788 E.01598
G1 X108.912 Y150.765 E.2525
G1 X108.377 Y150.765 E.01598
G1 X102.935 Y145.323 E.2299
G1 X102.935 Y145.857 E.01598
G1 X107.843 Y150.765 E.20731
G1 X107.308 Y150.765 E.01598
G1 X102.935 Y146.392 E.18472
G1 X102.935 Y146.927 E.01598
G1 X106.773 Y150.765 E.16213
G1 X106.238 Y150.765 E.01598
G1 X102.935 Y147.462 E.13953
G1 X102.935 Y147.997 E.01598
G1 X105.703 Y150.765 E.11694
G1 X105.169 Y150.765 E.01598
G1 X102.935 Y148.531 E.09435
G1 X102.935 Y149.066 E.01598
G1 X104.634 Y150.765 E.07176
G1 X104.099 Y150.765 E.01598
G1 X102.935 Y149.601 E.04916
G2 X103.256 Y150.457 I1.13 J.064 E.02811
G1 X103.685 Y150.886 E.01811
; WIPE_START
G1 X103.256 Y150.457 E-.23044
G1 X103.13 Y150.309 E-.07379
G1 X103.015 Y150.099 E-.09114
G1 X102.964 Y149.934 E-.06553
G1 X102.935 Y149.601 E-.12717
G1 X103.255 Y149.921 E-.17193
; WIPE_END
G1 E-.04 F1800
G1 X104.852 Y142.457 Z1 F30000
G1 X105.234 Y140.669 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X102.935 Y138.37 E.09712
G1 X102.935 Y137.835 E.01598
G1 X105.065 Y139.965 E.08996
G1 X105.065 Y139.43 E.01598
G1 X102.935 Y137.301 E.08995
G1 X102.935 Y136.766 E.01598
G1 X105.065 Y138.895 E.08995
G1 X105.065 Y138.36 E.01598
G1 X102.935 Y136.231 E.08995
G1 X102.935 Y135.696 E.01598
G1 X105.504 Y138.265 E.10851
G1 X106.039 Y138.265 E.01598
G1 X102.935 Y135.161 E.1311
G1 X102.935 Y134.627 E.01598
G1 X106.573 Y138.265 E.15369
G1 X107.108 Y138.265 E.01598
G1 X102.935 Y134.092 E.17629
G1 X102.935 Y133.557 E.01598
G1 X107.643 Y138.265 E.19888
G1 X108.178 Y138.265 E.01598
G1 X102.935 Y133.022 E.22147
G1 X102.935 Y132.487 E.01598
G1 X108.713 Y138.265 E.24406
G1 X109.247 Y138.265 E.01598
G1 X102.935 Y131.953 E.26666
G1 X102.935 Y131.418 E.01598
G1 X109.782 Y138.265 E.28925
G1 X110.317 Y138.265 E.01598
G1 X102.935 Y130.883 E.31184
G1 X102.935 Y130.348 E.01598
G1 X110.852 Y138.265 E.33444
G1 X111.387 Y138.265 E.01598
G1 X102.935 Y129.813 E.35703
G1 X102.935 Y129.279 E.01598
G1 X112.091 Y138.434 E.38679
; WIPE_START
G1 X110.677 Y137.02 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.309 Y137.083 Z1 F30000
G1 X118.766 Y137.087 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X119.643 Y137.965 E.03708
G1 X120.178 Y137.965 E.01598
G1 X118.935 Y136.722 E.05251
G1 X118.935 Y136.187 E.01598
G1 X120.713 Y137.965 E.0751
G1 X121.248 Y137.965 E.01598
G1 X119.018 Y135.735 E.09418
G1 X119.553 Y135.735 E.01598
G1 X121.783 Y137.965 E.09418
G1 X122.317 Y137.965 E.01598
G1 X120.088 Y135.735 E.09418
G1 X120.623 Y135.735 E.01598
G1 X122.852 Y137.965 E.09418
G1 X123.387 Y137.965 E.01598
G1 X121.158 Y135.735 E.09418
G1 X121.692 Y135.735 E.01598
G1 X123.922 Y137.965 E.09418
G1 X124.457 Y137.965 E.01598
G1 X122.227 Y135.735 E.09418
G1 X122.762 Y135.735 E.01598
G1 X124.991 Y137.965 E.09418
G1 X125.526 Y137.965 E.01598
G1 X123.297 Y135.735 E.09418
G1 X123.832 Y135.735 E.01598
G1 X126.061 Y137.965 E.09418
G1 X126.596 Y137.965 E.01598
G1 X124.366 Y135.735 E.09418
G1 X124.901 Y135.735 E.01598
G1 X127.131 Y137.965 E.09418
G1 X127.665 Y137.965 E.01598
G1 X125.436 Y135.735 E.09418
G1 X125.971 Y135.735 E.01598
G1 X128.2 Y137.965 E.09418
G1 X128.735 Y137.965 E.01598
G1 X126.506 Y135.735 E.09418
G1 X127.04 Y135.735 E.01598
G1 X129.27 Y137.965 E.09418
G1 X129.805 Y137.965 E.01598
G1 X127.575 Y135.735 E.09418
G1 X128.11 Y135.735 E.01598
G1 X130.339 Y137.965 E.09418
G1 X130.874 Y137.965 E.01598
G1 X128.645 Y135.735 E.09418
G1 X129.18 Y135.735 E.01598
G1 X131.409 Y137.965 E.09418
G1 X131.944 Y137.965 E.01598
G1 X129.714 Y135.735 E.09418
G1 X130.249 Y135.735 E.01598
G1 X132.479 Y137.965 E.09418
G1 X133.013 Y137.965 E.01598
G1 X130.784 Y135.735 E.09418
G1 X131.319 Y135.735 E.01598
G1 X133.548 Y137.965 E.09418
G1 X134.083 Y137.965 E.01598
G1 X131.854 Y135.735 E.09418
G1 X132.388 Y135.735 E.01598
G1 X134.618 Y137.965 E.09418
G1 X135.153 Y137.965 E.01598
G1 X132.923 Y135.735 E.09418
G1 X133.435 Y135.735 E.0153
G1 X133.435 Y135.713 E.00068
G1 X135.687 Y137.965 E.09514
G1 X136.222 Y137.965 E.01598
G1 X133.435 Y135.178 E.11773
G1 X133.435 Y134.643 E.01598
G1 X136.757 Y137.965 E.14032
G1 X137.292 Y137.965 E.01598
G1 X133.435 Y134.108 E.16292
G1 X133.435 Y133.573 E.01598
G1 X137.996 Y138.134 E.19268
; WIPE_START
G1 X136.582 Y136.72 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.601 Y138.134 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X117.602 Y116.135 E.92936
G1 X117.067 Y116.135 E.01598
G1 X138.896 Y137.965 E.92219
G1 X138.361 Y137.965 E.01598
G1 X116.362 Y115.966 E.92936
; WIPE_START
G1 X117.777 Y117.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.317 Y111.185 Z1 F30000
G1 X110.905 Y107.834 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X110.535 Y107.465 E.01562
G1 X110.535 Y106.93 E.01598
G1 X111.27 Y107.665 E.03104
G1 X111.805 Y107.665 E.01598
G1 X110.535 Y106.395 E.05364
G1 X110.535 Y105.86 E.01598
G1 X112.509 Y107.834 E.0834
; WIPE_START
G1 X111.095 Y106.42 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.734 Y110.059 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X112.935 Y108.26 E.076
G1 X112.935 Y108.795 E.01598
G1 X114.565 Y110.424 E.06883
G1 X114.565 Y110.959 E.01598
G1 X112.935 Y109.33 E.06883
G1 X112.935 Y109.865 E.01598
G1 X114.565 Y111.494 E.06883
G1 X114.565 Y112.029 E.01598
G1 X112.935 Y110.399 E.06883
G1 X112.935 Y110.735 E.01003
G1 X112.736 Y110.735 E.00594
G1 X114.565 Y112.564 E.07724
G1 X114.565 Y113.098 E.01598
G1 X112.202 Y110.735 E.09983
G1 X111.667 Y110.735 E.01598
G1 X114.565 Y113.633 E.12242
G1 X114.565 Y114.168 E.01598
G1 X111.132 Y110.735 E.14501
G1 X110.597 Y110.735 E.01598
G1 X114.565 Y114.703 E.16761
G1 X114.565 Y115.238 E.01598
G1 X110.535 Y111.208 E.17022
G1 X110.535 Y111.743 E.01598
G1 X114.565 Y115.772 E.17022
G1 X114.565 Y116.135 E.01084
G1 X114.928 Y116.135 E.01084
G1 X131.657 Y132.865 E.70674
G1 X132.192 Y132.865 E.01598
G1 X115.462 Y116.135 E.70674
G1 X115.997 Y116.135 E.01598
G1 X132.896 Y133.034 E.7139
; WIPE_START
G1 X131.482 Y131.62 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.292 Y133.034 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X110.535 Y112.278 E.87687
G1 X110.535 Y112.813 E.01598
G1 X130.587 Y132.865 E.8471
G1 X130.053 Y132.865 E.01598
G1 X110.323 Y113.135 E.83347
G1 X109.788 Y113.135 E.01598
G1 X129.518 Y132.865 E.83347
G1 X128.983 Y132.865 E.01598
G1 X109.254 Y113.135 E.83347
G1 X108.719 Y113.135 E.01598
G1 X128.448 Y132.865 E.83347
G1 X127.913 Y132.865 E.01598
G1 X108.014 Y112.966 E.84064
G1 X107.634 Y112.586 F30000
G1 F15000
G1 X105.784 Y110.735 E.07817
G1 X106.319 Y110.735 E.01598
G1 X107.465 Y111.881 E.04841
G1 X107.465 Y111.346 E.01598
G1 X106.854 Y110.735 E.02581
G1 X107.388 Y110.735 E.01598
G1 X107.634 Y110.981 E.01039
; WIPE_START
G1 X107.388 Y110.735 E-.13216
G1 X106.854 Y110.735 E-.20322
G1 X107.465 Y111.346 E-.32838
G1 X107.465 Y111.6 E-.09624
; WIPE_END
G1 E-.04 F1800
G1 X105.234 Y110.186 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X102.935 Y107.887 E.09712
G1 X102.935 Y107.352 E.01598
G1 X105.065 Y109.481 E.08995
G1 X105.065 Y108.946 E.01598
G1 X102.935 Y106.817 E.08995
G1 X102.935 Y106.282 E.01598
G1 X105.065 Y108.412 E.08995
G1 X105.065 Y107.877 E.01598
G1 X102.935 Y105.747 E.08996
G1 X102.935 Y105.213 E.01598
G1 X105.387 Y107.665 E.10359
G1 X105.922 Y107.665 E.01598
G1 X102.935 Y104.678 E.12618
G1 X102.935 Y104.143 E.01598
G1 X106.457 Y107.665 E.14877
G1 X106.992 Y107.665 E.01598
G1 X102.935 Y103.608 E.17137
G1 X102.935 Y103.073 E.01598
G1 X107.465 Y107.603 E.19134
G1 X107.465 Y107.068 E.01598
G1 X102.935 Y102.539 E.19134
G3 X102.974 Y102.043 I1.761 J-.11 E.0149
G1 X107.465 Y106.533 E.18969
G1 X107.465 Y105.998 E.01598
G1 X103.143 Y101.676 E.18258
G3 X103.41 Y101.417 I.784 J.539 E.01121
G1 X107.465 Y105.464 E.17112
G1 X107.465 Y105.265 E.00594
G1 X107.801 Y105.265 E.01003
G1 X103.797 Y101.261 E.16914
G3 X104.306 Y101.235 I.373 J2.35 E.01526
G1 X108.335 Y105.265 E.17022
G1 X108.87 Y105.265 E.01598
G1 X104.841 Y101.235 E.17022
G1 X105.376 Y101.235 E.01598
G1 X109.405 Y105.265 E.17022
G1 X109.94 Y105.265 E.01598
G1 X105.91 Y101.235 E.17022
G1 X106.445 Y101.235 E.01598
G1 X114.565 Y109.355 E.34301
G1 X114.565 Y108.82 E.01598
G1 X106.98 Y101.235 E.32041
G1 X107.515 Y101.235 E.01598
G1 X114.565 Y108.285 E.29782
G1 X114.565 Y107.75 E.01598
G1 X108.05 Y101.235 E.27523
G1 X108.585 Y101.235 E.01598
G1 X114.565 Y107.216 E.25263
G1 X114.565 Y106.681 E.01598
G1 X109.119 Y101.235 E.23004
G1 X109.654 Y101.235 E.01598
G1 X114.565 Y106.146 E.20745
M73 P27 R11
G1 X114.565 Y105.611 E.01598
G1 X110.189 Y101.235 E.18485
G1 X110.724 Y101.236 E.01598
G1 X114.565 Y105.076 E.16226
G1 X114.565 Y104.542 E.01598
G1 X111.259 Y101.236 E.13967
G1 X111.793 Y101.236 E.01598
G1 X114.565 Y104.007 E.11707
G1 X114.565 Y103.472 E.01598
G1 X112.328 Y101.236 E.09448
G1 X112.863 Y101.236 E.01598
G1 X114.565 Y102.937 E.07189
G1 X114.565 Y102.402 E.01598
G1 X113.398 Y101.236 E.04929
G1 X113.933 Y101.236 E.01598
G1 X114.962 Y102.265 E.04347
G1 X115.497 Y102.265 E.01598
G1 X114.467 Y101.236 E.04347
G1 X115.002 Y101.236 E.01598
G1 X116.031 Y102.265 E.04347
G1 X116.566 Y102.265 E.01598
G1 X115.537 Y101.236 E.04347
G1 X116.072 Y101.236 E.01598
G1 X117.101 Y102.265 E.04347
G1 X117.636 Y102.265 E.01598
G1 X116.607 Y101.236 E.04347
G1 X117.142 Y101.236 E.01598
G1 X118.171 Y102.265 E.04347
G1 X118.705 Y102.265 E.01598
G1 X117.676 Y101.236 E.04347
G1 X118.211 Y101.236 E.01598
G1 X119.24 Y102.265 E.04347
G1 X119.775 Y102.265 E.01598
G1 X118.746 Y101.236 E.04347
G1 X119.281 Y101.236 E.01598
G1 X120.31 Y102.265 E.04347
G1 X120.845 Y102.265 E.01598
G1 X119.816 Y101.236 E.04347
G1 X120.35 Y101.236 E.01598
G1 X121.379 Y102.265 E.04347
G1 X121.914 Y102.265 E.01598
G1 X120.885 Y101.236 E.04347
G1 X121.42 Y101.236 E.01598
G1 X122.449 Y102.265 E.04347
G1 X122.984 Y102.265 E.01598
G1 X121.955 Y101.236 E.04346
G1 X122.49 Y101.236 E.01598
G1 X123.519 Y102.265 E.04346
G1 X124.053 Y102.265 E.01598
G1 X123.024 Y101.236 E.04346
G1 X123.559 Y101.236 E.01598
G1 X124.588 Y102.265 E.04346
G1 X125.123 Y102.265 E.01598
G1 X124.094 Y101.236 E.04346
G1 X124.629 Y101.236 E.01598
G1 X125.658 Y102.265 E.04346
G1 X126.193 Y102.265 E.01598
G1 X125.164 Y101.236 E.04346
G1 X125.699 Y101.236 E.01598
G1 X126.727 Y102.265 E.04346
G1 X127.262 Y102.265 E.01598
G1 X126.233 Y101.236 E.04346
G1 X126.768 Y101.236 E.01598
G1 X127.797 Y102.265 E.04346
G1 X128.332 Y102.265 E.01598
G1 X127.303 Y101.236 E.04346
G1 X127.838 Y101.236 E.01598
G1 X128.867 Y102.265 E.04346
G1 X129.401 Y102.265 E.01598
G1 X128.373 Y101.236 E.04346
G1 X128.907 Y101.236 E.01598
G1 X129.936 Y102.265 E.04346
G1 X130.471 Y102.265 E.01598
G1 X129.442 Y101.236 E.04346
G1 X129.977 Y101.236 E.01598
G1 X131.006 Y102.265 E.04346
G1 X131.541 Y102.265 E.01598
G1 X130.512 Y101.236 E.04345
G1 X131.047 Y101.236 E.01598
G1 X132.075 Y102.265 E.04345
G1 X132.61 Y102.265 E.01598
G1 X131.582 Y101.236 E.04345
G1 X132.116 Y101.236 E.01598
G1 X138.245 Y107.365 E.2589
G1 X138.78 Y107.365 E.01598
G1 X132.651 Y101.236 E.2589
G1 X133.186 Y101.236 E.01598
G1 X139.315 Y107.365 E.2589
G1 X139.849 Y107.365 E.01598
G1 X133.721 Y101.236 E.2589
G1 X134.256 Y101.236 E.01598
G1 X140.384 Y107.365 E.2589
G1 X140.919 Y107.365 E.01598
G1 X134.79 Y101.236 E.2589
G1 X135.325 Y101.236 E.01598
G1 X141.454 Y107.365 E.2589
G1 X141.988 Y107.365 E.01598
G1 X135.86 Y101.236 E.2589
G1 X136.395 Y101.236 E.01598
G1 X142.523 Y107.365 E.2589
G1 X143.058 Y107.365 E.01598
G1 X136.93 Y101.236 E.2589
G1 X137.464 Y101.236 E.01598
G1 X143.593 Y107.365 E.2589
G1 X144.128 Y107.365 E.01598
G1 X137.999 Y101.236 E.2589
G1 X138.534 Y101.236 E.01598
G1 X144.662 Y107.365 E.2589
G1 X145.197 Y107.365 E.01598
G1 X139.069 Y101.236 E.2589
G1 X139.604 Y101.236 E.01598
G1 X145.732 Y107.365 E.2589
G1 X146.267 Y107.365 E.01598
G1 X140.139 Y101.236 E.25889
G1 X140.673 Y101.236 E.01598
G1 X146.802 Y107.365 E.25889
G1 X147.336 Y107.365 E.01598
G1 X141.208 Y101.236 E.25889
G1 X141.743 Y101.236 E.01598
G1 X147.871 Y107.365 E.25889
G1 X148.406 Y107.365 E.01598
G1 X142.278 Y101.236 E.25889
G1 X142.813 Y101.236 E.01598
G1 X148.941 Y107.365 E.25889
G1 X149.476 Y107.365 E.01598
G1 X143.347 Y101.236 E.25889
G1 X143.882 Y101.236 E.01598
G1 X150.01 Y107.365 E.25889
G1 X150.545 Y107.365 E.01598
G1 X144.417 Y101.236 E.25889
G1 X144.952 Y101.236 E.01598
G1 X151.08 Y107.365 E.25889
G1 X151.615 Y107.365 E.01598
G1 X145.487 Y101.236 E.25889
G1 X146.021 Y101.236 E.01598
G1 X152.15 Y107.365 E.25889
G1 X152.684 Y107.365 E.01598
G1 X146.556 Y101.236 E.25889
G1 X147.091 Y101.236 E.01598
G1 X153.065 Y107.21 E.25236
G1 X153.065 Y106.675 E.01598
G1 X147.626 Y101.237 E.22976
G1 X148.161 Y101.237 E.01598
G1 X153.065 Y106.14 E.20717
G1 X153.065 Y105.606 E.01598
G1 X148.696 Y101.237 E.18458
G1 X149.23 Y101.237 E.01598
G1 X153.065 Y105.071 E.16198
G1 X153.065 Y104.536 E.01598
G1 X149.765 Y101.237 E.13939
G1 X150.3 Y101.237 E.01598
G1 X153.065 Y104.001 E.1168
G1 X153.065 Y103.466 E.01598
G1 X150.835 Y101.237 E.0942
G1 X151.37 Y101.237 E.01598
G1 X153.065 Y102.932 E.07161
G1 X153.065 Y102.397 E.01598
G1 X151.904 Y101.237 E.04902
G3 X152.527 Y101.377 I.05 J1.231 E.01929
G3 X153.191 Y101.988 I-2.221 J3.076 E.02703
; WIPE_START
G1 X152.77 Y101.568 E-.22602
G1 X152.527 Y101.377 E-.11757
G1 X152.239 Y101.264 E-.11735
G1 X151.904 Y101.237 E-.12774
G1 X152.223 Y101.555 E-.17131
; WIPE_END
G1 E-.04 F1800
G1 X152.983 Y109.15 Z1 F30000
G1 X153.234 Y111.658 Z1
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X152.612 Y111.035 E.02631
G1 X152.077 Y111.035 E.01598
G1 X153.065 Y112.023 E.04174
G1 X153.065 Y112.558 E.01598
G1 X151.542 Y111.035 E.06433
G1 X151.007 Y111.035 E.01598
G1 X153.065 Y113.093 E.08692
G1 X153.065 Y113.628 E.01598
G1 X150.472 Y111.035 E.10951
G1 X149.938 Y111.035 E.01598
G1 X153.065 Y114.162 E.13211
G1 X153.065 Y114.697 E.01598
G1 X149.403 Y111.035 E.1547
G1 X148.868 Y111.035 E.01598
G1 X153.065 Y115.232 E.17729
G1 X153.065 Y115.767 E.01598
G1 X148.333 Y111.035 E.19989
G1 X147.798 Y111.035 E.01598
G1 X153.065 Y116.302 E.22248
G1 X153.065 Y116.836 E.01598
G1 X147.264 Y111.035 E.24507
G1 X146.729 Y111.035 E.01598
G1 X153.065 Y117.371 E.26766
G1 X153.065 Y117.906 E.01598
G1 X146.194 Y111.035 E.29026
G1 X145.659 Y111.035 E.01598
G1 X153.065 Y118.441 E.31285
G1 X153.065 Y118.976 E.01598
G1 X145.124 Y111.035 E.33544
G1 X144.59 Y111.035 E.01598
G1 X153.065 Y119.51 E.35803
G1 X153.065 Y120.045 E.01598
G1 X144.055 Y111.035 E.38063
G1 X143.52 Y111.035 E.01598
G1 X153.065 Y120.58 E.40322
G1 X153.065 Y121.115 E.01598
G1 X142.985 Y111.035 E.42581
G1 X142.45 Y111.035 E.01598
G1 X153.065 Y121.65 E.44841
G1 X153.065 Y122.184 E.01598
G1 X141.916 Y111.035 E.471
G1 X141.381 Y111.035 E.01598
G1 X153.065 Y122.719 E.49359
G1 X153.065 Y123.254 E.01598
G1 X140.846 Y111.035 E.51618
G1 X140.311 Y111.035 E.01598
G1 X153.065 Y123.789 E.53878
G1 X153.065 Y124.324 E.01598
G1 X139.776 Y111.035 E.56137
G1 X139.242 Y111.035 E.01598
G1 X153.065 Y124.858 E.58396
G1 X153.065 Y125.393 E.01598
G1 X138.707 Y111.035 E.60655
G1 X138.172 Y111.035 E.01598
G1 X153.065 Y125.928 E.62915
G1 X153.065 Y126.463 E.01598
G1 X137.637 Y111.035 E.65174
G1 X137.102 Y111.035 E.01598
G1 X153.065 Y126.998 E.67433
G1 X153.065 Y127.532 E.01598
G1 X136.568 Y111.035 E.69693
G1 X136.033 Y111.035 E.01598
G1 X153.065 Y128.067 E.71952
G1 X153.065 Y128.602 E.01598
G1 X135.498 Y111.035 E.74211
G1 X134.963 Y111.035 E.01598
G1 X153.065 Y129.137 E.7647
G1 X153.065 Y129.672 E.01598
G1 X134.428 Y111.035 E.7873
G1 X133.894 Y111.035 E.01598
G1 X153.065 Y130.206 E.80989
G1 X153.065 Y130.741 E.01598
G1 X133.359 Y111.035 E.83248
G1 X132.824 Y111.035 E.01598
G1 X153.065 Y131.276 E.85507
G1 X153.065 Y131.811 E.01598
G1 X132.289 Y111.035 E.87767
G1 X131.754 Y111.035 E.01598
G1 X153.065 Y132.346 E.90026
G1 X153.065 Y132.88 E.01598
G1 X142.912 Y122.728 E.4289
G1 X142.932 Y122.862 E.00404
G1 X142.917 Y123.268 E.01214
G1 X153.065 Y133.415 E.42869
G1 X153.065 Y133.95 E.01598
G1 X142.801 Y123.687 E.43358
G3 X142.625 Y124.045 I-1.033 J-.286 E.012
G1 X153.065 Y134.485 E.44103
G1 X153.065 Y135.02 E.01598
G1 X142.384 Y124.339 E.4512
G3 X142.096 Y124.586 I-.684 J-.508 E.01143
G1 X153.065 Y135.554 E.46338
G1 X153.065 Y136.089 E.01598
G1 X141.754 Y124.779 E.47782
G3 X141.337 Y124.896 I-.519 J-1.044 E.01303
G1 X153.065 Y136.624 E.49545
G1 X153.065 Y137.159 E.01598
G1 X140.628 Y124.722 E.52541
; WIPE_START
G1 X142.042 Y126.136 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.274 Y123.368 Z1 F30000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X132.041 Y116.135 E.30555
G1 X132.576 Y116.135 E.01598
G1 X139.098 Y122.658 E.27553
G1 X139.22 Y122.245 E.01286
G1 X133.111 Y116.135 E.25809
M73 P28 R11
G1 X133.435 Y116.135 E.00969
G1 X133.435 Y115.925 E.00628
G1 X139.415 Y121.905 E.25261
G3 X139.659 Y121.614 I.76 J.389 E.01144
G1 X133.435 Y115.39 E.26291
G1 X133.435 Y114.855 E.01598
G1 X139.954 Y121.374 E.27538
G3 X140.314 Y121.2 I.641 J.866 E.01203
G1 X133.435 Y114.321 E.29061
G1 X133.435 Y113.786 E.01598
G1 X140.888 Y121.238 E.31483
G1 X141.489 Y121.305 F30000
G1 F15000
G1 X131.22 Y111.035 E.43383
G1 X130.685 Y111.035 E.01598
G1 X132.914 Y113.265 E.09418
G1 X132.379 Y113.265 E.01598
G1 X130.15 Y111.035 E.09418
G1 X129.615 Y111.035 E.01598
G1 X131.845 Y113.265 E.09418
G1 X131.31 Y113.265 E.01598
G1 X129.08 Y111.035 E.09418
G1 X128.546 Y111.035 E.01598
G1 X130.775 Y113.265 E.09418
G1 X130.24 Y113.265 E.01598
G1 X128.011 Y111.035 E.09418
G1 X127.476 Y111.035 E.01598
G1 X129.705 Y113.265 E.09418
G1 X129.171 Y113.265 E.01598
G1 X126.941 Y111.035 E.09418
G1 X126.406 Y111.035 E.01598
G1 X128.636 Y113.265 E.09418
G1 X128.101 Y113.265 E.01598
G1 X125.872 Y111.035 E.09418
G1 X125.337 Y111.035 E.01598
G1 X127.566 Y113.265 E.09418
G1 X127.031 Y113.265 E.01598
G1 X124.802 Y111.035 E.09418
G1 X124.267 Y111.035 E.01598
G1 X126.497 Y113.265 E.09418
G1 X125.962 Y113.265 E.01598
G1 X123.732 Y111.035 E.09418
G1 X123.198 Y111.035 E.01598
G1 X125.427 Y113.265 E.09418
G1 X124.892 Y113.265 E.01598
G1 X122.663 Y111.035 E.09418
G1 X122.128 Y111.035 E.01598
G1 X124.357 Y113.265 E.09418
G1 X123.823 Y113.265 E.01598
G1 X121.593 Y111.035 E.09418
G1 X121.058 Y111.035 E.01598
G1 X123.288 Y113.265 E.09418
G1 X122.753 Y113.265 E.01598
G1 X120.524 Y111.035 E.09418
G1 X119.989 Y111.035 E.01598
G1 X122.218 Y113.265 E.09418
G1 X121.683 Y113.265 E.01598
G1 X119.549 Y111.131 E.09016
G1 X119.549 Y111.239 E.00323
G1 X119.123 Y111.239 E.01274
G1 X121.149 Y113.265 E.08559
G1 X120.614 Y113.265 E.01598
G1 X118.935 Y111.586 E.07091
G1 X118.935 Y112.121 E.01598
G1 X120.079 Y113.265 E.04831
G1 X119.544 Y113.265 E.01598
G1 X118.935 Y112.656 E.02572
G1 X118.935 Y113.191 E.01598
G1 X119.179 Y113.434 E.0103
; WIPE_START
G1 X118.935 Y113.191 E-.13097
G1 X118.935 Y112.656 E-.20322
G1 X119.544 Y113.265 E-.32719
G1 X119.804 Y113.265 E-.09862
; WIPE_END
G1 E-.04 F1800
G1 X119 Y110.905 Z1 F30000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y107.494 E.10476
G1 X118.766 Y106.603 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42108
G1 F15000
G1 X119.323 Y107.161 E.02357
G1 X119.549 Y107.161 E.00674
G1 X119.549 Y107.365 E.00608
G1 X120.062 Y107.365 E.01531
G1 X118.935 Y106.238 E.04759
G1 X118.935 Y105.703 E.01598
G1 X120.597 Y107.365 E.07018
G1 X121.131 Y107.365 E.01598
G1 X118.935 Y105.169 E.09277
G1 X118.935 Y105.135 E.001
G1 X119.437 Y105.135 E.01498
G1 X121.666 Y107.365 E.09418
G1 X122.201 Y107.365 E.01598
G1 X119.972 Y105.135 E.09418
G1 X120.506 Y105.135 E.01598
G1 X122.736 Y107.365 E.09418
G1 X123.271 Y107.365 E.01598
G1 X121.041 Y105.135 E.09418
G1 X121.576 Y105.135 E.01598
G1 X123.805 Y107.365 E.09418
G1 X124.34 Y107.365 E.01598
G1 X122.111 Y105.135 E.09418
G1 X122.646 Y105.135 E.01598
G1 X124.875 Y107.365 E.09418
G1 X125.41 Y107.365 E.01598
G1 X123.18 Y105.135 E.09418
G1 X123.715 Y105.135 E.01598
G1 X125.945 Y107.365 E.09418
G1 X126.479 Y107.365 E.01598
G1 X124.25 Y105.135 E.09418
G1 X124.785 Y105.135 E.01598
G1 X127.014 Y107.365 E.09418
G1 X127.549 Y107.365 E.01598
G1 X125.32 Y105.135 E.09418
G1 X125.854 Y105.135 E.01598
G1 X128.084 Y107.365 E.09418
G1 X128.619 Y107.365 E.01598
G1 X126.389 Y105.135 E.09418
G1 X126.924 Y105.135 E.01598
G1 X129.153 Y107.365 E.09418
G1 X129.688 Y107.365 E.01598
G1 X127.459 Y105.135 E.09418
G1 X127.994 Y105.135 E.01598
G1 X130.223 Y107.365 E.09418
G1 X130.758 Y107.365 E.01598
G1 X128.528 Y105.135 E.09418
G1 X129.063 Y105.135 E.01598
G1 X131.293 Y107.365 E.09418
G1 X131.827 Y107.365 E.01598
G1 X129.598 Y105.135 E.09418
G1 X130.133 Y105.135 E.01598
G1 X132.362 Y107.365 E.09418
G1 X132.897 Y107.365 E.01598
G1 X130.668 Y105.135 E.09418
G1 X131.202 Y105.135 E.01598
G1 X133.432 Y107.365 E.09418
G1 X133.967 Y107.365 E.01598
G1 X131.737 Y105.135 E.09418
G1 X132.272 Y105.135 E.01598
G1 X134.501 Y107.365 E.09418
G1 X135.036 Y107.365 E.01598
G1 X132.807 Y105.135 E.09418
G1 X133.342 Y105.135 E.01598
G1 X135.571 Y107.365 E.09418
G1 X136.106 Y107.365 E.01598
G1 X133.435 Y104.694 E.11281
G1 X133.435 Y104.159 E.01598
G1 X136.641 Y107.365 E.1354
G1 X137.175 Y107.365 E.01598
G1 X133.435 Y103.625 E.158
G1 X133.435 Y103.09 E.01598
G1 X137.88 Y107.534 E.18776
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X136.466 Y106.12 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 4/22
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S91.8
G17
G3 Z1 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.618 Y122.206
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.68 Y122.1 E.00395
G3 X127.89 Y121.402 I1.325 J.899 E.0465
G1 X128 Y121.398 E.00354
G3 X126.513 Y122.416 I.005 J1.602 E.26205
G1 X126.592 Y122.26 E.00563
M204 S250
G1 X126.963 Y122.388 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X127.003 Y122.32 E.00235
G3 X127.918 Y121.793 I1.001 J.679 E.03256
G1 X128 Y121.79 E.00244
G3 X126.878 Y122.559 I.004 J1.21 E.18331
G1 X126.936 Y122.442 E.00391
; WIPE_START
M204 S10000
G1 X127.003 Y122.32 E-.05272
G1 X127.113 Y122.177 E-.06871
G1 X127.245 Y122.054 E-.06867
G1 X127.475 Y121.91 E-.10298
G1 X127.731 Y121.82 E-.10297
G1 X127.918 Y121.793 E-.072
G1 X128 Y121.79 E-.03111
G1 X128.18 Y121.803 E-.06873
G1 X128.442 Y121.874 E-.10299
G1 X128.612 Y121.957 E-.07196
G1 X128.649 Y121.983 E-.01716
; WIPE_END
G1 E-.04 F1800
G1 X121.024 Y122.337 Z1.2 F30000
G1 X116.528 Y122.546 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.566 Y122.642 E.00335
G3 X114.89 Y121.402 I-1.561 J.357 E.2506
G1 X115 Y121.398 E.00354
G3 X116.447 Y122.303 I.005 J1.602 E.05789
G1 X116.509 Y122.489 E.00629
M204 S250
G1 X116.16 Y122.674 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.183 Y122.73 E.00179
G3 X114.918 Y121.793 I-1.179 J.27 E.17531
G1 X115 Y121.79 E.00244
G3 X116.093 Y122.473 I.004 J1.21 E.04051
G1 X116.141 Y122.617 E.00452
; WIPE_START
M204 S10000
G1 X116.183 Y122.73 E-.04561
G1 X116.207 Y122.91 E-.06919
G1 X116.197 Y123.18 E-.10263
G1 X116.156 Y123.357 E-.06878
G1 X116.048 Y123.605 E-.10296
G1 X115.893 Y123.817 E-.0997
G1 X115.755 Y123.946 E-.072
G1 X115.524 Y124.091 E-.10326
G1 X115.286 Y124.174 E-.09587
; WIPE_END
G1 E-.04 F1800
G1 X116.095 Y131.763 Z1.2 F30000
G1 X117.656 Y146.402 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.08868
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y135.402 E.07088
G1 X118.602 Y135.402 E.46627
G1 X118.602 Y144.198 E.28284
G1 X133.102 Y144.198 E.46627
G1 X133.102 Y146.402 E.07088
G1 X117.716 Y146.402 E.49477
; WIPE_START
G1 X115.716 Y146.402 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y144.59 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y144.59 E.43191
G1 X132.71 Y146.01 E.0423
G1 X115.29 Y146.01 E.51888
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y135.01 E.0423
G1 X118.21 Y135.01 E.43191
G1 X118.21 Y144.53 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y144.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.153 Y141.631 Z1.2 F30000
G1 X105.79 Y138.598 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.381 Y131.422 Z1.2 F30000
G1 X110.202 Y107.998 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.532 Y114.376 Z1.2 F30000
G1 X117.656 Y115.802 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.08867
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y104.802 E.07088
G1 X118.602 Y104.802 E.46627
G1 X118.602 Y113.598 E.28284
G1 X133.102 Y113.598 E.46627
G1 X133.102 Y115.802 E.07088
G1 X117.716 Y115.802 E.49478
; WIPE_START
G1 X115.716 Y115.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y113.99 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y113.99 E.43191
G1 X132.71 Y115.41 E.0423
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y104.41 E.0423
G1 X118.21 Y104.41 E.43191
G1 X118.21 Y113.93 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y113.938 E-.76
; WIPE_END
M73 P29 R11
G1 E-.04 F1800
G1 X127.33 Y116.687 Z1.2 F30000
G1 X142.531 Y122.555 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.566 Y122.642 E.00302
G3 X140.89 Y121.402 I-1.561 J.357 E.2506
G1 X141 Y121.398 E.00354
G3 X142.447 Y122.303 I.005 J1.602 E.05789
G1 X142.512 Y122.498 E.00662
M204 S250
G1 X142.163 Y122.684 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.183 Y122.73 E.00148
G3 X140.918 Y121.793 I-1.179 J.27 E.17531
G1 X141 Y121.79 E.00244
G3 X142.093 Y122.473 I.004 J1.21 E.04051
G1 X142.145 Y122.627 E.00482
; WIPE_START
M204 S10000
G1 X142.183 Y122.73 E-.0417
G1 X142.207 Y122.91 E-.06919
G1 X142.197 Y123.18 E-.10263
G1 X142.156 Y123.357 E-.06878
G1 X142.048 Y123.605 E-.10295
G1 X141.893 Y123.817 E-.0997
G1 X141.755 Y123.946 E-.072
G1 X141.524 Y124.091 E-.10326
G1 X141.277 Y124.177 E-.09978
; WIPE_END
G1 E-.04 F1800
G1 X134.864 Y128.316 Z1.2 F30000
G1 X119.398 Y138.298 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X119.398 Y141.302 E.0966
G1 X153.398 Y141.302 E1.09332
G1 X153.398 Y149.689 E.26969
G3 X151.989 Y151.098 I-1.405 J.004 E.07123
G1 X104.011 Y151.098 E1.54278
G3 X102.602 Y149.684 I0 J-1.409 E.07133
G1 X102.602 Y102.311 E1.52335
G3 X104.011 Y100.902 I1.405 J-.004 E.07122
G1 X152.039 Y100.904 E1.5444
G3 X153.398 Y102.311 I-.041 J1.399 E.06964
G1 X153.398 Y107.698 E.17322
G1 X119.398 Y107.698 E1.09332
G1 X119.398 Y110.702 E.0966
G1 X153.398 Y110.702 E1.09332
G1 X153.398 Y138.298 E.88738
G1 X119.458 Y138.298 E1.09139
M204 S250
G1 X119.79 Y138.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X119.79 Y140.91 E.06613
G1 X153.79 Y140.91 E1.01274
G1 X153.79 Y149.696 E.26171
G3 X152.175 Y151.48 I-1.803 J-.009 E.07848
G3 X151.996 Y151.49 I-.157 J-1.25 E.00535
G1 X104.004 Y151.49 E1.42952
G3 X102.21 Y149.695 I.009 J-1.803 E.08387
G1 X102.21 Y102.304 E1.4116
G3 X103.825 Y100.52 I1.803 J.009 E.07848
G3 X104.004 Y100.51 I.157 J1.25 E.00535
G1 X152.047 Y100.512 E1.43102
G3 X153.79 Y102.304 I-.048 J1.791 E.08243
G1 X153.79 Y108.09 E.17235
G1 X119.79 Y108.09 E1.01274
G1 X119.79 Y110.31 E.06613
G1 X153.79 Y110.31 E1.01274
G1 X153.79 Y138.69 E.84534
G1 X119.85 Y138.69 E1.01096
; WIPE_START
M204 S10000
G1 X119.796 Y140.689 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119 Y138.095 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y141.506 E.10476
; WIPE_START
G1 X119 Y139.506 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.55 Y133.949 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.55 Y135.578 E.05236
G1 X102.95 Y123.978 E.52749
G1 X102.95 Y120.346 E.1168
G1 X110.146 Y113.15 E.32722
G1 X110.55 Y113.15 E.01301
G1 X110.55 Y112.746 E.01301
G1 X112.546 Y110.75 E.09075
G1 X112.75 Y110.75 E.00657
G1 X114.55 Y112.55 E.08183
G1 X114.55 Y108.747 E.1223
G1 X112.95 Y110.346 E.07273
G1 X112.95 Y108.718 E.05236
; WIPE_START
G1 X112.95 Y110.346 E-.61876
G1 X113.213 Y110.083 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X119 Y107.494 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.43172
G1 F15000
G1 X119 Y110.905 E.10476
; WIPE_START
G1 X119 Y108.905 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.368 Y108.926 Z1.2 F30000
G1 X105.05 Y108.942 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.05 Y110.571 E.05236
G1 X102.95 Y112.67 E.09547
G1 X102.95 Y116.302 E.1168
G1 X119.498 Y132.85 E.75251
G1 X121.15 Y132.85 E.05314
G1 X142.95 Y111.05 E.99135
G1 X143.754 Y111.05 E.02587
G1 X153.05 Y120.346 E.42272
G1 X153.05 Y123.978 E.1168
G1 X139.078 Y137.95 E.63537
G1 X139.95 Y137.95 E.02802
G1 X118.15 Y116.15 E.99135
G1 X114.822 Y116.15 E.10703
G1 X102.95 Y128.022 E.53987
G1 X102.95 Y131.654 E.1168
G1 X109.546 Y138.25 E.29994
G1 X108.074 Y138.25 E.04732
G1 X130.174 Y116.15 E1.00499
G1 X133.45 Y116.15 E.10536
G1 X133.45 Y116.098 E.00167
G1 X139.339 Y121.987 E.26781
G2 X139.106 Y122.57 I1.169 J.806 E.02033
G1 X128.826 Y132.85 E.46749
G1 X127.174 Y132.85 E.05314
G1 X116.905 Y122.581 E.46698
G2 X116.661 Y121.987 I-2.811 J.805 E.0207
G1 X122.498 Y116.15 E.26541
G1 X125.826 Y116.15 E.10703
G1 X147.626 Y137.95 E.99135
G1 X146.754 Y137.95 E.02802
G1 X153.05 Y131.654 E.2863
G1 X153.05 Y128.022 E.1168
G1 X136.078 Y111.05 E.7718
G1 X135.274 Y111.05 E.02587
G1 X134.005 Y112.319 E.05768
G1 X134.005 Y113.947 E.05236
; WIPE_START
G1 X134.005 Y112.319 E-.61876
G1 X134.268 Y112.056 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X133.554 Y115.494 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5392
G1 F12694.447
G1 X133.554 Y113.454 E.07995
G1 X133.554 Y113.394 F30000
; LINE_WIDTH: 0.519332
G1 F13223.857
G1 X133.574 Y113.229 E.00627
; LINE_WIDTH: 0.479595
G1 F14427.206
G1 X133.593 Y113.064 E.00575
; LINE_WIDTH: 0.420091
G1 F15000
G1 X133.613 Y112.898 E.00496
G1 X133.613 Y111.094 E.05375
G1 X119.608 Y111.094 E.41727
G1 X119.513 Y111.272 E.00601
G1 X118.994 Y111.298 E.01549
G1 X118.994 Y113.206 E.05686
G1 X133.306 Y113.206 E.42639
; LINE_WIDTH: 0.439859
G1 X133.372 Y113.257 E.00263
; LINE_WIDTH: 0.479595
G1 F14427.206
G1 X133.439 Y113.307 E.00289
; LINE_WIDTH: 0.519332
G1 F13223.857
G1 X133.506 Y113.358 E.00316
G1 X133.236 Y112.829 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X133.236 Y111.471 E.04044
G1 X119.789 Y111.471 E.40053
G1 X119.701 Y111.599 E.00463
G1 X119.371 Y111.675 E.01009
G1 X119.371 Y112.829 E.03438
G1 X133.176 Y112.829 E.4112
G1 X132.803 Y112.395 F30000
; LINE_WIDTH: 0.53318
G1 F12850.324
G1 X132.803 Y111.905 E.01899
G1 X119.989 Y111.905 E.49625
G3 X119.805 Y112.005 I-.18 J-.11 E.00849
G1 X119.805 Y112.395 E.01509
G1 X132.743 Y112.395 E.50104
; WIPE_START
G1 X130.743 Y112.395 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.005 Y106.271 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.005 Y104.643 E.05236
G1 X137.396 Y101.252 E.15422
G1 X133.955 Y101.251 E.11066
G1 X140.053 Y107.35 E.27732
G1 X138.974 Y107.35 E.0347
G1 X145.072 Y101.252 E.2773
G1 X141.632 Y101.252 E.11064
G1 X147.729 Y107.35 E.27731
G1 X146.65 Y107.35 E.0347
G1 X152.574 Y101.426 E.26938
G2 X152.018 Y101.252 I-.677 J1.189 E.01887
G1 X149.308 Y101.252 E.08715
G1 X153.05 Y104.994 E.17017
G1 X153.05 Y106.622 E.05236
; WIPE_START
G1 X153.05 Y104.994 E-.61876
G1 X152.787 Y104.731 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X145.155 Y104.857 Z1.2 F30000
G1 X133.552 Y105.049 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.539239
G1 F12693.454
G1 X133.554 Y102.966 E.08165
; WIPE_START
G1 X133.552 Y104.966 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.803 Y106.495 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.533185
M73 P30 R11
G1 F12850.193
G1 X132.803 Y106.005 E.01899
G1 X119.805 Y106.005 E.50337
G1 X119.805 Y106.395 E.01509
G1 X119.967 Y106.455 E.0067
G1 X119.989 Y106.495 E.00176
G1 X132.743 Y106.495 E.49393
G1 X133.236 Y106.929 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X133.236 Y105.571 E.04044
G1 X119.371 Y105.571 E.41298
G1 X119.371 Y106.725 E.03438
G1 X119.729 Y106.818 E.01102
G1 X119.789 Y106.929 E.00376
G1 X133.176 Y106.929 E.39874
G1 X133.613 Y107.306 F30000
G1 F15000
G1 X133.613 Y105.502 E.05373
; LINE_WIDTH: 0.440482
G1 X133.593 Y105.351 E.00479
; LINE_WIDTH: 0.481465
G1 F14365.687
G1 X133.572 Y105.2 E.00528
; LINE_WIDTH: 0.522449
G1 F13137.911
G1 X133.552 Y105.049 E.00577
G1 X133.47 Y105.097 E.00361
; LINE_WIDTH: 0.481465
G1 F14365.687
G1 X133.388 Y105.146 E.0033
; LINE_WIDTH: 0.420053
G1 F15000
G1 X133.306 Y105.194 E.00284
G1 X118.994 Y105.194 E.42635
G1 X118.994 Y107.102 E.05685
M73 P30 R10
G1 X119.513 Y107.128 E.01549
G1 X119.623 Y107.306 E.00623
G1 X133.553 Y107.306 E.415
; WIPE_START
G1 X131.553 Y107.306 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.349 Y101.251 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X129.721 Y101.251 E.05236
G1 X128.722 Y102.25 E.0454
G1 X127.278 Y102.25 E.04646
G1 X126.279 Y101.251 E.04541
G1 X122.045 Y101.251 E.13615
G1 X121.047 Y102.25 E.04542
G1 X119.602 Y102.25 E.04646
G1 X118.603 Y101.251 E.04542
G1 X116.974 Y101.251 E.05236
; WIPE_START
G1 X118.603 Y101.251 E-.61876
G1 X118.866 Y101.514 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X121.683 Y108.607 Z1.2 F30000
G1 X132.803 Y136.605 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.53318
G1 F12850.324
G1 X119.805 Y136.605 E.50336
G1 X119.805 Y136.995 E.01509
G1 X119.967 Y137.055 E.0067
G1 X119.989 Y137.095 E.00176
G1 X132.803 Y137.095 E.49625
G1 X132.803 Y136.665 E.01666
G1 X133.236 Y136.171 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X119.371 Y136.171 E.41298
G1 X119.371 Y137.325 E.03438
G1 X119.729 Y137.418 E.01102
G1 X119.789 Y137.529 E.00376
G1 X133.236 Y137.529 E.40053
G1 X133.236 Y136.231 E.03865
G1 X133.552 Y135.649 F30000
; LINE_WIDTH: 0.539239
G1 F12693.454
G1 X133.554 Y133.566 E.08165
; WIPE_START
G1 X133.552 Y135.566 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.552 Y135.649 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.522449
G1 F13137.911
G1 X133.47 Y135.697 E.00361
; LINE_WIDTH: 0.481465
G1 F14365.687
G1 X133.388 Y135.746 E.0033
; LINE_WIDTH: 0.42005
G1 F15000
G1 X133.306 Y135.794 E.00284
G1 X118.994 Y135.794 E.42635
G1 X118.994 Y137.702 E.05685
G1 X119.513 Y137.728 E.01549
G1 X119.623 Y137.906 E.00623
G1 X133.613 Y137.906 E.41678
G1 X133.613 Y136.102 E.05374
; LINE_WIDTH: 0.440482
G1 X133.596 Y135.971 E.00416
; LINE_WIDTH: 0.481465
G1 F14365.687
G1 X133.578 Y135.839 E.00459
; LINE_WIDTH: 0.522449
G1 F13137.911
G1 X133.56 Y135.708 E.00502
; WIPE_START
G1 X133.578 Y135.839 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.005 Y136.975 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.005 Y135.347 E.05236
G1 X153.05 Y116.302 E.86606
G1 X153.05 Y112.67 E.1168
G1 X151.43 Y111.05 E.07365
G1 X150.626 Y111.05 E.02587
G1 X140.581 Y121.095 E.45678
G3 X142.009 Y124.658 I.412 J1.903 E.1756
G1 X153.05 Y135.698 E.50206
G1 X153.05 Y137.326 E.05236
; WIPE_START
G1 X153.05 Y135.698 E-.61876
G1 X152.787 Y135.435 E-.14125
; WIPE_END
G1 E-.04 F1800
G1 X145.935 Y138.797 Z1.2 F30000
G1 X134.005 Y144.651 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F15476.087
G1 X134.005 Y143.023 E.05236
G1 X135.378 Y141.65 E.0624
G1 X135.974 Y141.65 E.01919
G1 X145.074 Y150.75 E.4138
G1 X141.63 Y150.75 E.11073
G1 X150.729 Y141.65 E.4138
G1 X151.326 Y141.65 E.01919
G1 X153.049 Y143.373 E.07833
G1 X153.047 Y147.009 E.11692
G1 X149.306 Y150.75 E.17012
G1 X151.97 Y150.75 E.08566
G2 X152.575 Y150.575 I-.009 J-1.165 E.02051
G1 X143.65 Y141.65 E.40585
G1 X143.053 Y141.65 E.01919
G1 X133.954 Y150.75 E.4138
G1 X137.398 Y150.75 E.11073
G1 X133.398 Y146.75 E.18187
G1 X130.278 Y146.75 E.10036
G1 X126.278 Y150.75 E.18187
G1 X129.722 Y150.75 E.11073
G1 X125.722 Y146.75 E.18187
G1 X122.602 Y146.75 E.10036
G1 X118.602 Y150.75 E.18187
G1 X122.046 Y150.75 E.11073
G1 X118.047 Y146.75 E.18187
G1 X114.926 Y146.75 E.10036
G1 X110.926 Y150.75 E.18187
G1 X114.37 Y150.75 E.11073
G1 X102.95 Y139.33 E.51932
G1 X102.95 Y135.698 E.1168
G1 X113.985 Y124.663 E.5018
G3 X115.43 Y121.106 I1.018 J-1.658 E.17599
G1 X102.95 Y108.626 E.56753
G1 X102.95 Y104.994 E.1168
G1 X106.694 Y101.25 E.17024
G1 X104.03 Y101.25 E.08565
G2 X103.425 Y101.425 I.009 J1.165 E.02051
G1 X107.45 Y105.45 E.18302
G1 X107.45 Y105.25 E.00643
G1 X110.371 Y105.25 E.09393
G1 X114.37 Y101.251 E.18186
G1 X110.927 Y101.251 E.11071
G1 X114.55 Y104.874 E.16477
G1 X114.55 Y103.245 E.05236
; WIPE_START
G1 X114.55 Y104.874 E-.61876
G1 X114.287 Y104.611 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X112.422 Y112.012 Z1.2 F30000
G1 X105.05 Y141.274 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F15476.087
G1 X102.95 Y143.374 E.09547
G1 X102.95 Y147.006 E.1168
G1 X106.694 Y150.75 E.17024
G1 X104.026 Y150.75 E.08579
G3 X103.426 Y150.574 I.022 J-1.19 E.02034
G1 X112.647 Y141.35 E.41939
G1 X114.55 Y143.253 E.08655
G1 X114.55 Y139.45 E.1223
G1 X112.95 Y141.05 E.07273
G1 X112.95 Y139.421 E.05236
; WIPE_START
G1 X112.95 Y141.05 E-.61876
G1 X113.213 Y140.787 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X120.598 Y142.714 Z1.2 F30000
G1 X133.554 Y146.094 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5392
G1 F12694.447
G1 X133.554 Y144.054 E.07995
; WIPE_START
G1 X133.554 Y146.054 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.803 Y142.505 Z1.2 F30000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.53319
G1 F12850.062
G1 X119.989 Y142.505 E.49626
G3 X119.805 Y142.605 I-.18 J-.11 E.00849
G1 X119.805 Y142.995 E.01509
G1 X132.803 Y142.995 E.50337
G1 X132.803 Y142.565 E.01666
G1 X133.236 Y142.071 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X119.789 Y142.071 E.40053
G1 X119.701 Y142.199 E.00463
G1 X119.371 Y142.275 E.01009
G1 X119.371 Y143.429 E.03438
G1 X133.236 Y143.429 E.41298
G1 X133.236 Y142.131 E.03865
G1 X133.613 Y141.694 F30000
G1 F15000
G1 X119.608 Y141.694 E.41716
G1 X119.513 Y141.872 E.00601
G1 X118.994 Y141.898 E.01549
G1 X118.994 Y143.806 E.05684
G1 X133.306 Y143.806 E.42628
; LINE_WIDTH: 0.439859
G1 X133.388 Y143.869 E.00326
; LINE_WIDTH: 0.479595
G1 F14427.206
G1 X133.471 Y143.932 E.00358
; LINE_WIDTH: 0.519332
G1 F13223.857
G1 X133.554 Y143.994 E.00391
G1 X133.574 Y143.829 E.00627
; LINE_WIDTH: 0.479595
G1 F14427.206
G1 X133.593 Y143.664 E.00575
; LINE_WIDTH: 0.421723
G1 F15000
G1 X133.613 Y143.498 E.00499
G1 X133.613 Y141.754 E.05219
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X133.613 Y143.498 E-.69373
G1 X133.593 Y143.664 E-.06627
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 5/22
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S51
G17
G3 Z1.2 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.592 Y122.246
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.619 Y122.199 E.00175
G3 X127.895 Y121.401 I1.388 J.8 E.05038
G1 X128 Y121.398 E.00338
G3 X126.476 Y122.53 I.007 J1.602 E.25823
G1 X126.569 Y122.302 E.00792
M204 S250
G1 X126.949 Y122.402 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.957 Y122.397 E.00031
G3 X127.922 Y121.793 I1.049 J.602 E.03531
G1 X128 Y121.79 E.00231
G3 X126.85 Y122.645 I.006 J1.209 E.18065
G1 X126.926 Y122.458 E.00602
; WIPE_START
M204 S10000
G1 X126.957 Y122.397 E-.02609
G1 X127.113 Y122.177 E-.10235
G1 X127.318 Y122 E-.10297
G1 X127.476 Y121.909 E-.0692
G1 X127.731 Y121.82 E-.10254
G1 X127.922 Y121.793 E-.07362
G1 X128 Y121.79 E-.02949
G1 X128.18 Y121.803 E-.06871
G1 X128.442 Y121.874 E-.10302
G1 X128.606 Y121.952 E-.06906
G1 X128.633 Y121.973 E-.01296
; WIPE_END
G1 E-.04 F1800
G1 X136.259 Y122.296 Z1.4 F30000
G1 X142.534 Y122.563 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.568 Y122.642 E.00278
G3 X140.895 Y121.401 I-1.561 J.357 E.25068
G1 X141 Y121.398 E.00338
G3 X142.449 Y122.302 I.007 J1.602 E.05793
G1 X142.515 Y122.506 E.00688
M204 S250
G1 X142.166 Y122.691 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.185 Y122.73 E.00127
G3 X140.922 Y121.793 I-1.179 J.27 E.17537
G1 X141 Y121.79 E.00231
G3 X142.095 Y122.473 I.006 J1.209 E.04054
G1 X142.147 Y122.634 E.00506
; WIPE_START
M204 S10000
G1 X142.185 Y122.73 E-.03886
G1 X142.207 Y122.911 E-.06933
G1 X142.197 Y123.18 E-.10251
G1 X142.126 Y123.442 E-.10304
G1 X142 Y123.682 E-.10296
G1 X141.887 Y123.823 E-.0687
G1 X141.682 Y124 E-.10296
G1 X141.525 Y124.09 E-.06879
G1 X141.27 Y124.18 E-.10285
; WIPE_END
G1 E-.04 F1800
G1 X134.076 Y121.628 Z1.4 F30000
G1 X117.656 Y115.802 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.08867
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y104.802 E.07088
G1 X118.602 Y104.802 E.46627
G1 X118.602 Y113.598 E.28284
G1 X133.102 Y113.598 E.46627
G1 X133.102 Y115.802 E.07088
G1 X117.716 Y115.802 E.49478
; WIPE_START
G1 X115.716 Y115.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y113.99 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y113.99 E.43191
G1 X132.71 Y115.41 E.0423
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y104.41 E.0423
G1 X118.21 Y104.41 E.43191
G1 X118.21 Y113.93 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y113.938 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.647 Y110.043 Z1.4 F30000
G1 X110.202 Y107.998 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
M73 P31 R10
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.222 Y115.621 Z1.4 F30000
G1 X116.532 Y122.555 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.568 Y122.642 E.00302
G3 X114.895 Y121.401 I-1.561 J.357 E.25068
G1 X115 Y121.398 E.00338
G3 X116.449 Y122.302 I.007 J1.602 E.05793
G1 X116.513 Y122.498 E.00664
M204 S250
G1 X116.164 Y122.684 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.185 Y122.73 E.00149
G3 X114.922 Y121.793 I-1.179 J.27 E.17537
G1 X115 Y121.79 E.00231
G3 X116.095 Y122.473 I.006 J1.209 E.04054
G1 X116.145 Y122.627 E.00484
; WIPE_START
M204 S10000
G1 X116.185 Y122.73 E-.04176
G1 X116.207 Y122.911 E-.06933
G1 X116.197 Y123.18 E-.10251
G1 X116.126 Y123.442 E-.10304
G1 X116 Y123.682 E-.10296
G1 X115.887 Y123.823 E-.0687
G1 X115.682 Y124 E-.10296
G1 X115.525 Y124.09 E-.06879
G1 X115.277 Y124.177 E-.09994
; WIPE_END
G1 E-.04 F1800
G1 X116.089 Y131.766 Z1.4 F30000
G1 X117.656 Y146.402 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.08868
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y135.402 E.07088
G1 X118.602 Y135.402 E.46627
G1 X118.602 Y144.198 E.28284
G1 X133.102 Y144.198 E.46627
G1 X133.102 Y146.402 E.07088
G1 X117.716 Y146.402 E.49477
; WIPE_START
G1 X115.716 Y146.402 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y144.59 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y144.59 E.43191
G1 X132.71 Y146.01 E.0423
G1 X115.29 Y146.01 E.51888
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y135.01 E.0423
G1 X118.21 Y135.01 E.43191
G1 X118.21 Y144.53 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y144.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.153 Y141.631 Z1.4 F30000
G1 X105.79 Y138.598 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.191 Y140.896 Z1.4 F30000
G1 X153.168 Y150.463 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X151.989 Y151.098 I-1.175 J-.77 E.0449
G1 X104.011 Y151.098 E1.54279
G3 X102.602 Y149.689 I-.008 J-1.401 E.07128
G1 X102.602 Y102.311 E1.52351
G3 X104.011 Y100.902 I1.405 J-.004 E.07122
G1 X152.054 Y100.904 E1.54487
G3 X153.398 Y102.311 I-.055 J1.398 E.06917
G1 X153.398 Y106.917 E.14813
G1 X153.398 Y107.317 E.01286
G1 F13999.876
G1 X153.398 Y107.717 E.01286
G1 F6459.938
G1 X153.398 Y108.117 E.01286
M106 S255
G1 F1800
G1 X153.398 Y108.5 E.0123
M106 S51
; FEATURE: Overhang wall
M106 S255
G1 F3000
M204 S5000
G1 X153.398 Y109.9 E.04502
M106 S51
; FEATURE: Inner wall
M106 S255
G1 F1800
M204 S10000
G1 X153.398 Y110.282 E.0123
M106 S51
G1 F6459.938
G1 X153.398 Y110.682 E.01286
G1 F13999.876
G1 X153.398 Y111.082 E.01286
G1 F15476.087
G1 X153.398 Y111.482 E.01286
G1 X153.398 Y137.517 E.83719
G1 X153.398 Y137.917 E.01286
G1 F13999.876
G1 X153.398 Y138.317 E.01286
G1 F6459.938
G1 X153.398 Y138.717 E.01286
M106 S255
G1 F1800
G1 X153.398 Y139.1 E.0123
M106 S51
; FEATURE: Overhang wall
M106 S255
G1 F3000
M204 S5000
G1 X153.398 Y140.5 E.04502
M106 S51
; FEATURE: Inner wall
M106 S255
G1 F1800
M204 S10000
G1 X153.398 Y140.882 E.0123
M106 S51
G1 F6459.938
G1 X153.398 Y141.282 E.01286
G1 F13999.876
G1 X153.398 Y141.682 E.01286
G1 F15476.087
G1 X153.398 Y142.082 E.01286
G1 X153.398 Y149.689 E.2446
G3 X153.2 Y150.412 I-1.405 J.004 E.02439
M204 S250
G1 X153.494 Y150.681 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.502 J-.989 E.05283
G1 X104.004 Y151.49 E1.42952
G3 X102.21 Y149.696 I0 J-1.794 E.08394
G1 X102.21 Y102.304 E1.41166
G3 X104.004 Y100.51 I1.798 J.005 E.08388
G1 X152.061 Y100.512 E1.43145
G3 X153.79 Y102.304 I-.063 J1.791 E.08199
G1 X153.79 Y107.331 E.14974
G1 X153.79 Y107.731 E.01191
G1 F6459.938
G1 X153.79 Y108.131 E.01191
M106 S255
G1 F1800
G1 X153.79 Y108.5 E.01099
M106 S51
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X153.79 Y109.9 E.04502
M106 S51
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F1800
G1 X153.79 Y110.269 E.01099
M106 S51
G1 F6459.938
G1 X153.79 Y110.669 E.01191
G1 F12000
G1 X153.79 Y111.069 E.01191
G1 X153.79 Y137.931 E.80013
G1 X153.79 Y138.331 E.01191
G1 F6459.938
G1 X153.79 Y138.731 E.01191
M106 S255
G1 F1800
G1 X153.79 Y139.1 E.01099
M106 S51
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X153.79 Y140.5 E.04502
M106 S51
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F1800
G1 X153.79 Y140.869 E.01099
M106 S51
G1 F6459.938
G1 X153.79 Y141.269 E.01191
G1 F12000
G1 X153.79 Y141.669 E.01191
G1 X153.79 Y149.696 E.2391
G3 X153.526 Y150.63 I-1.798 J-.005 E.02927
; WIPE_START
M204 S10000
G1 X153.295 Y150.935 E-.14524
G1 X152.993 Y151.189 E-.14984
G1 X152.697 Y151.348 E-.12786
G1 X152.392 Y151.446 E-.12189
G1 X151.996 Y151.49 E-.1513
G1 X151.828 Y151.49 E-.06386
; WIPE_END
G1 E-.04 F1800
G1 X152.766 Y143.915 Z1.4 F30000
G1 X153.064 Y141.507 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42211
M106 S255
G1 F3000
G1 X153.064 Y138.262 E.09719
G1 X152.684 Y138.262 E.01136
G1 X152.684 Y141.338 E.09211
G1 X152.305 Y141.338 E.01136
G1 X152.305 Y138.262 E.09211
G1 X151.926 Y138.262 E.01136
G1 X151.926 Y141.338 E.09211
G1 X151.547 Y141.338 E.01136
G1 X151.547 Y138.262 E.09211
G1 X151.168 Y138.262 E.01136
G1 X151.168 Y141.338 E.09211
G1 X150.789 Y141.338 E.01136
G1 X150.789 Y138.262 E.09211
G1 X150.409 Y138.262 E.01136
G1 X150.409 Y141.338 E.09211
G1 X150.03 Y141.338 E.01136
G1 X150.03 Y138.262 E.09211
G1 X149.651 Y138.262 E.01136
G1 X149.651 Y141.338 E.09211
G1 X149.272 Y141.338 E.01136
G1 X149.272 Y138.262 E.09211
G1 X148.893 Y138.262 E.01136
G1 X148.893 Y141.338 E.09211
G1 X148.513 Y141.338 E.01136
G1 X148.513 Y138.262 E.09211
G1 X148.134 Y138.262 E.01136
G1 X148.134 Y141.338 E.09211
G1 X147.755 Y141.338 E.01136
G1 X147.755 Y138.262 E.09211
G1 X147.376 Y138.262 E.01136
G1 X147.376 Y141.338 E.09211
G1 X146.997 Y141.338 E.01136
G1 X146.997 Y138.262 E.09211
G1 X146.617 Y138.262 E.01136
G1 X146.617 Y141.338 E.09211
G1 X146.238 Y141.338 E.01136
G1 X146.238 Y138.262 E.09211
G1 X145.859 Y138.262 E.01136
G1 X145.859 Y141.338 E.09211
G1 X145.48 Y141.338 E.01136
G1 X145.48 Y138.262 E.09211
G1 X145.101 Y138.262 E.01136
G1 X145.101 Y141.338 E.09211
G1 X144.721 Y141.338 E.01136
G1 X144.721 Y138.262 E.09211
G1 X144.342 Y138.262 E.01136
G1 X144.342 Y141.338 E.09211
G1 X143.963 Y141.338 E.01136
G1 X143.963 Y138.262 E.09211
G1 X143.584 Y138.262 E.01136
G1 X143.584 Y141.338 E.09211
G1 X143.205 Y141.338 E.01136
G1 X143.205 Y138.262 E.09211
G1 X142.826 Y138.262 E.01136
G1 X142.826 Y141.338 E.09211
G1 X142.446 Y141.338 E.01136
G1 X142.446 Y138.262 E.09211
G1 X142.067 Y138.262 E.01136
G1 X142.067 Y141.338 E.09211
G1 X141.688 Y141.338 E.01136
G1 X141.688 Y138.262 E.09211
G1 X141.309 Y138.262 E.01136
G1 X141.309 Y141.338 E.09211
G1 X140.93 Y141.338 E.01136
G1 X140.93 Y138.262 E.09211
G1 X140.55 Y138.262 E.01136
G1 X140.55 Y141.338 E.09211
G1 X140.171 Y141.338 E.01136
G1 X140.171 Y138.262 E.09211
G1 X139.792 Y138.262 E.01136
G1 X139.792 Y141.338 E.09211
G1 X139.413 Y141.338 E.01136
G1 X139.413 Y138.262 E.09211
G1 X139.034 Y138.262 E.01136
G1 X139.034 Y141.338 E.09211
G1 X138.654 Y141.338 E.01136
G1 X138.654 Y138.262 E.09211
G1 X138.275 Y138.262 E.01136
G1 X138.275 Y141.338 E.09211
G1 X137.896 Y141.338 E.01136
G1 X137.896 Y138.262 E.09211
G1 X137.517 Y138.262 E.01136
G1 X137.517 Y141.338 E.09211
G1 X137.138 Y141.338 E.01136
G1 X137.138 Y138.262 E.09211
M73 P32 R10
G1 X136.758 Y138.262 E.01136
G1 X136.758 Y141.338 E.09211
G1 X136.379 Y141.338 E.01136
G1 X136.379 Y138.262 E.09211
G1 X136 Y138.262 E.01136
G1 X136 Y141.338 E.09211
G1 X135.621 Y141.338 E.01136
G1 X135.621 Y138.262 E.09211
G1 X135.242 Y138.262 E.01136
G1 X135.242 Y141.338 E.09211
G1 X134.863 Y141.338 E.01136
G1 X134.863 Y138.262 E.09211
G1 X134.483 Y138.262 E.01136
G1 X134.483 Y141.338 E.09211
G1 X134.104 Y141.338 E.01136
G1 X134.104 Y138.262 E.09211
G1 X133.816 Y138.262 E.00862
G1 X133.725 Y138.171 E.00387
G1 X133.725 Y141.429 E.09759
G1 X133.613 Y141.541 E.00473
G1 X133.613 Y141.917 E.01128
G1 X133.346 Y141.917 E.00801
G1 X133.346 Y137.683 E.12684
G1 X132.967 Y137.683 E.01136
G1 X132.967 Y141.917 E.12684
G1 X132.587 Y141.917 E.01136
G1 X132.587 Y137.683 E.12684
G1 X132.208 Y137.683 E.01136
G1 X132.208 Y141.917 E.12684
G1 X131.829 Y141.917 E.01136
G1 X131.829 Y137.683 E.12684
G1 X131.45 Y137.683 E.01136
G1 X131.45 Y141.917 E.12684
G1 X131.071 Y141.917 E.01136
G1 X131.071 Y137.683 E.12684
G1 X130.691 Y137.683 E.01136
G1 X130.691 Y141.917 E.12684
G1 X130.312 Y141.917 E.01136
G1 X130.312 Y137.683 E.12684
G1 X129.933 Y137.683 E.01136
G1 X129.933 Y141.917 E.12684
G1 X129.554 Y141.917 E.01136
G1 X129.554 Y137.683 E.12684
G1 X129.175 Y137.683 E.01136
G1 X129.175 Y141.917 E.12684
G1 X128.796 Y141.917 E.01136
G1 X128.796 Y137.683 E.12684
G1 X128.416 Y137.683 E.01136
G1 X128.416 Y141.917 E.12684
G1 X128.037 Y141.917 E.01136
G1 X128.037 Y137.683 E.12684
G1 X127.658 Y137.683 E.01136
G1 X127.658 Y141.917 E.12684
G1 X127.279 Y141.917 E.01136
G1 X127.279 Y137.683 E.12684
G1 X126.9 Y137.683 E.01136
G1 X126.9 Y141.917 E.12684
G1 X126.52 Y141.917 E.01136
G1 X126.52 Y137.683 E.12684
G1 X126.141 Y137.683 E.01136
G1 X126.141 Y141.917 E.12684
G1 X125.762 Y141.917 E.01136
G1 X125.762 Y137.683 E.12684
G1 X125.383 Y137.683 E.01136
G1 X125.383 Y141.917 E.12684
G1 X125.004 Y141.917 E.01136
G1 X125.004 Y137.683 E.12684
G1 X124.624 Y137.683 E.01136
G1 X124.624 Y141.917 E.12684
G1 X124.245 Y141.917 E.01136
G1 X124.245 Y137.683 E.12684
G1 X123.866 Y137.683 E.01136
G1 X123.866 Y141.917 E.12684
G1 X123.487 Y141.917 E.01136
G1 X123.487 Y137.683 E.12684
G1 X123.108 Y137.683 E.01136
G1 X123.108 Y141.917 E.12684
G1 X122.819 Y141.917 E.00864
G1 X122.819 Y141.541 E.01128
G1 X122.728 Y141.45 E.00385
G1 X122.728 Y138.15 E.09884
G1 X122.616 Y138.262 E.00476
G1 X122.349 Y138.262 E.00799
G1 X122.349 Y141.338 E.09211
G1 X121.97 Y141.338 E.01136
G1 X121.97 Y138.262 E.09211
G1 X121.591 Y138.262 E.01136
G1 X121.591 Y141.338 E.09211
G1 X121.212 Y141.338 E.01136
G1 X121.212 Y138.262 E.09211
G1 X120.833 Y138.262 E.01136
G1 X120.833 Y141.338 E.09211
G1 X120.453 Y141.338 E.01136
G1 X120.453 Y138.262 E.09211
G1 X120.074 Y138.262 E.01136
G1 X120.074 Y141.338 E.09211
G1 X119.695 Y141.338 E.01136
G1 X119.695 Y138.262 E.09211
G3 X119.316 Y138.135 I-.078 J-.394 E.01255
G1 X119.316 Y141.465 E.09976
G3 X119.153 Y141.541 I-.119 J-.043 E.00596
G1 X119.136 Y141.558 E.00072
G1 X119.069 Y141.481 E.00306
G1 X118.937 Y141.269 E.0075
G1 X118.937 Y138.013 E.09753
M106 S51
; WIPE_START
G1 X118.937 Y140.013 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.327 Y139.044 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X113.327 Y140.673 E.05236
G1 X114.172 Y139.827 E.03843
G1 X114.172 Y142.876 E.09804
G1 X113.024 Y141.727 E.05224
G1 X112.272 Y141.727 E.02416
G1 X103.705 Y150.295 E.3896
G1 X103.878 Y150.357 E.00589
G2 X104.044 Y150.373 I.126 J-.443 E.00539
G1 X106.317 Y150.373 E.0731
G1 X103.327 Y147.383 E.13594
G1 X103.327 Y142.997 E.14106
G1 X104.672 Y141.652 E.06117
G1 X104.672 Y141.052 E.01927
G1 X103.327 Y139.707 E.06117
G1 X103.327 Y138.079 E.05236
; WIPE_START
G1 X103.327 Y139.707 E-.61876
G1 X103.59 Y139.97 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X105.035 Y141.206 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383733
G1 F12000
G1 X105.063 Y141.337 E.00363
G1 X105.194 Y141.365 E.00363
G1 X112.806 Y141.365 E.20491
G1 X112.937 Y141.337 E.00363
G1 X112.965 Y141.206 E.00363
G1 X112.965 Y138.394 E.07568
G1 X112.937 Y138.263 E.00363
G1 X112.806 Y138.235 E.00363
G1 X105.194 Y138.235 E.20491
G1 X105.063 Y138.263 E.00363
G1 X105.035 Y138.394 E.00363
G1 X105.035 Y141.146 E.07407
; WIPE_START
G1 X105.035 Y139.146 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.551 Y132.371 Z1.4 F30000
G1 X114.375 Y121.151 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.38292
G1 F12000
G1 X114.634 Y121.073 E.00726
G1 X115.276 Y121.054 E.01725
G1 X115.726 Y121.174 E.01249
G3 X116.385 Y121.613 I-.814 J1.937 E.02142
G1 X116.735 Y122.086 E.0158
G1 X116.91 Y122.57 E.01382
G3 X116.68 Y124.016 I-1.953 J.43 E.04025
G1 X116.341 Y124.425 E.01428
G1 X115.86 Y124.768 E.01585
G1 X115.353 Y124.929 E.01429
G3 X113.568 Y124.333 I-.346 J-1.934 E.0527
G1 X113.268 Y123.92 E.01372
G1 X113.089 Y123.428 E.01405
G1 X113.052 Y122.772 E.01766
G1 X113.175 Y122.275 E.01375
G3 X113.581 Y121.656 I1.8 J.739 E.01999
; WIPE_START
G1 X113.354 Y121.937 E-.13725
G1 X113.175 Y122.275 E-.14518
G1 X113.052 Y122.772 E-.19458
G1 X113.089 Y123.428 E-.24982
G1 X113.119 Y123.51 E-.03317
; WIPE_END
G1 E-.04 F1800
G1 X118.24 Y117.851 Z1.4 F30000
G1 X119.766 Y116.165 Z1.4
G1 Z1
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.398038
G1 F3000;_EXTRUDE_SET_SPEED
G1 X114.694 Y116.165 E.14227
G1 X114.563 Y116.137 E.00378
G1 X114.535 Y116.006 E.00378
G1 X114.535 Y102.394 E.38182
G1 X114.563 Y102.263 E.00378
G1 X114.694 Y102.235 E.00378
G1 X116.146 Y102.235 E.04072
; Slow Down End
; WIPE_START
G1 X114.694 Y102.235 E-.55163
G1 X114.563 Y102.263 E-.05117
G1 X114.535 Y102.394 E-.05117
G1 X114.535 Y102.673 E-.10602
; WIPE_END
G1 E-.04 F1800
G1 X116.975 Y101.251 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.603 Y101.251 E.05236
G1 X119.602 Y102.25 E.04541
G1 X121.047 Y102.25 E.04646
G1 X122.045 Y101.251 E.04541
G1 X126.279 Y101.251 E.13616
G1 X127.278 Y102.25 E.0454
G1 X128.722 Y102.25 E.04646
G1 X129.721 Y101.252 E.04539
G1 X131.271 Y101.252 E.04984
G1 X131.308 Y101.32 E.00252
G1 X131.692 Y101.266 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F12000
G1 X152.022 Y101.267 E.54601
G1 X152.467 Y101.384 E.01236
G1 X152.763 Y101.612 E.01003
G1 X152.973 Y101.969 E.01111
G1 X153.035 Y102.334 E.00995
G1 X153.035 Y107.255 E.13217
; WIPE_START
G1 X153.035 Y105.255 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X152.673 Y106.245 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X152.673 Y104.617 E.05236
G1 X149.685 Y101.63 E.13584
G1 X152.011 Y101.63 E.07479
G3 X152.298 Y101.702 I-.11 J1.042 E.00953
G1 X146.73 Y107.27 E.25322
G1 X147.65 Y107.27 E.0296
G1 X142.009 Y101.629 E.25653
G1 X144.695 Y101.629 E.08635
G1 X139.054 Y107.27 E.25653
G1 X139.974 Y107.27 E.0296
G1 X134.333 Y101.629 E.25655
G1 X137.019 Y101.629 E.08638
G1 X134.005 Y104.643 E.13705
G1 X134.005 Y103.014 E.05236
; WIPE_START
G1 X134.005 Y104.643 E-.61876
G1 X134.268 Y104.38 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X132.222 Y102.235 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.386907
G1 F12000
G1 X133.306 Y102.235 E.02944
G1 X133.437 Y102.263 E.00366
G1 X133.466 Y102.686 E.01153
G1 X133.554 Y102.896 E.00619
; LINE_WIDTH: 0.5392
G1 X133.554 Y104.989 E.08204
G1 X133.552 Y105.049 F30000
; LINE_WIDTH: 0.522449
G1 F12000
G1 X133.47 Y105.097 E.00361
; LINE_WIDTH: 0.481465
G1 X133.388 Y105.146 E.0033
; LINE_WIDTH: 0.42005
G1 X133.306 Y105.194 E.00284
G1 X118.994 Y105.194 E.42635
G2 X118.997 Y107.064 I151.396 J.718 E.05569
G1 X119.245 Y107.046 E.00741
G3 X119.625 Y107.285 I-.177 J.703 E.01362
G1 X122.442 Y107.285 E.08392
G1 X122.471 Y106.794 E.01466
G1 X122.631 Y106.706 E.00544
G1 X133.613 Y106.706 E.32717
G1 X133.613 Y105.502 E.03586
; LINE_WIDTH: 0.440482
G1 X133.596 Y105.371 E.00416
; LINE_WIDTH: 0.481465
G1 X133.578 Y105.239 E.00459
; LINE_WIDTH: 0.522449
G1 X133.56 Y105.108 E.00502
G1 X133.236 Y105.571 F30000
; LINE_WIDTH: 0.41999
G1 F12000
G1 X119.371 Y105.571 E.41298
G1 X119.371 Y106.715 E.03406
G1 X119.637 Y106.803 E.00833
G1 X119.765 Y106.908 E.00494
G1 X122.065 Y106.908 E.06852
G1 X122.151 Y106.594 E.0097
G1 X122.533 Y106.337 E.01371
G1 X122.631 Y106.329 E.00292
G1 X133.236 Y106.329 E.31589
G1 X133.236 Y105.631 E.02077
; WIPE_START
G1 X133.236 Y106.329 E-.26501
G1 X131.934 Y106.329 E-.49499
; WIPE_END
G1 E-.04 F1800
G1 X124.307 Y106.029 Z1.4 F30000
G1 X122.466 Y105.957 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.423364
G1 F12000
G1 X132.798 Y105.95 E.31047
; WIPE_START
G1 X130.798 Y105.951 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.165 Y105.957 Z1.4 F30000
G1 X122.466 Y105.957 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.458918
G1 F12000
G1 X122.025 Y105.978 E.01451
; LINE_WIDTH: 0.521
G1 X121.584 Y106 E.01667
G1 X119.8 Y106 E.0674
G1 X119.8 Y106.415 E.01568
G1 X119.978 Y106.48 E.00717
G1 X121.756 Y106.48 E.06712
G1 X121.788 Y106.367 E.00443
; LINE_WIDTH: 0.501633
G1 X122.102 Y106.178 E.01328
; LINE_WIDTH: 0.458918
G1 X122.415 Y105.988 E.01204
; WIPE_START
G1 X122.102 Y106.178 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.937 Y107.413 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42211
M106 S255
G1 F3000
G1 X118.937 Y110.669 E.09753
G1 X119.069 Y110.881 E.0075
G1 X119.136 Y110.958 E.00306
G1 X119.153 Y110.941 E.00072
G2 X119.316 Y110.865 I.043 J-.119 E.00596
G1 X119.316 Y107.535 E.09976
G2 X119.695 Y107.662 I.301 J-.266 E.01255
G1 X119.695 Y110.738 E.09211
G1 X120.074 Y110.738 E.01136
G1 X120.074 Y107.662 E.09211
G1 X120.453 Y107.662 E.01136
G1 X120.453 Y110.738 E.09211
G1 X120.833 Y110.738 E.01136
G1 X120.833 Y107.662 E.09211
M73 P33 R10
G1 X121.212 Y107.662 E.01136
G1 X121.212 Y110.738 E.09211
G1 X121.591 Y110.738 E.01136
G1 X121.591 Y107.662 E.09211
G1 X121.97 Y107.662 E.01136
G1 X121.97 Y110.738 E.09211
G1 X122.349 Y110.738 E.01136
G1 X122.349 Y107.662 E.09211
G1 X122.616 Y107.662 E.00799
G1 X122.728 Y107.55 E.00476
G1 X122.728 Y110.85 E.09884
G1 X122.819 Y110.941 E.00385
G1 X122.819 Y111.317 E.01128
G1 X123.108 Y111.317 E.00864
G1 X123.108 Y107.083 E.12684
G1 X123.487 Y107.083 E.01136
G1 X123.487 Y111.317 E.12684
G1 X123.866 Y111.317 E.01136
G1 X123.866 Y107.083 E.12684
G1 X124.245 Y107.083 E.01136
G1 X124.245 Y111.317 E.12684
G1 X124.624 Y111.317 E.01136
G1 X124.624 Y107.083 E.12684
G1 X125.004 Y107.083 E.01136
G1 X125.004 Y111.317 E.12684
G1 X125.383 Y111.317 E.01136
G1 X125.383 Y107.083 E.12684
G1 X125.762 Y107.083 E.01136
G1 X125.762 Y111.317 E.12684
G1 X126.141 Y111.317 E.01136
G1 X126.141 Y107.083 E.12684
G1 X126.52 Y107.083 E.01136
G1 X126.52 Y111.317 E.12684
G1 X126.9 Y111.317 E.01136
G1 X126.9 Y107.083 E.12684
G1 X127.279 Y107.083 E.01136
G1 X127.279 Y111.317 E.12684
G1 X127.658 Y111.317 E.01136
G1 X127.658 Y107.083 E.12684
G1 X128.037 Y107.083 E.01136
G1 X128.037 Y111.317 E.12684
G1 X128.416 Y111.317 E.01136
G1 X128.416 Y107.083 E.12684
G1 X128.796 Y107.083 E.01136
G1 X128.796 Y111.317 E.12684
G1 X129.175 Y111.317 E.01136
G1 X129.175 Y107.083 E.12684
G1 X129.554 Y107.083 E.01136
G1 X129.554 Y111.317 E.12684
G1 X129.933 Y111.317 E.01136
G1 X129.933 Y107.083 E.12684
G1 X130.312 Y107.083 E.01136
G1 X130.312 Y111.317 E.12684
G1 X130.691 Y111.317 E.01136
G1 X130.691 Y107.083 E.12684
G1 X131.071 Y107.083 E.01136
G1 X131.071 Y111.317 E.12684
G1 X131.45 Y111.317 E.01136
G1 X131.45 Y107.083 E.12684
G1 X131.829 Y107.083 E.01136
G1 X131.829 Y111.317 E.12684
G1 X132.208 Y111.317 E.01136
G1 X132.208 Y107.083 E.12684
G1 X132.587 Y107.083 E.01136
G1 X132.587 Y111.317 E.12684
G1 X132.967 Y111.317 E.01136
G1 X132.967 Y107.083 E.12684
G1 X133.346 Y107.083 E.01136
G1 X133.346 Y111.317 E.12684
G1 X133.613 Y111.317 E.00801
G1 X133.613 Y110.941 E.01128
G1 X133.725 Y110.829 E.00473
G1 X133.725 Y107.571 E.09759
G1 X133.816 Y107.662 E.00387
G1 X134.104 Y107.662 E.00862
G1 X134.104 Y110.738 E.09211
G1 X134.483 Y110.738 E.01136
G1 X134.483 Y107.662 E.09211
G1 X134.863 Y107.662 E.01136
G1 X134.863 Y110.738 E.09211
G1 X135.242 Y110.738 E.01136
G1 X135.242 Y107.662 E.09211
G1 X135.621 Y107.662 E.01136
G1 X135.621 Y110.738 E.09211
G1 X136 Y110.738 E.01136
G1 X136 Y107.662 E.09211
G1 X136.379 Y107.662 E.01136
G1 X136.379 Y110.738 E.09211
G1 X136.758 Y110.738 E.01136
G1 X136.758 Y107.662 E.09211
G1 X137.138 Y107.662 E.01136
G1 X137.138 Y110.738 E.09211
G1 X137.517 Y110.738 E.01136
G1 X137.517 Y107.662 E.09211
G1 X137.896 Y107.662 E.01136
G1 X137.896 Y110.738 E.09211
G1 X138.275 Y110.738 E.01136
G1 X138.275 Y107.662 E.09211
G1 X138.654 Y107.662 E.01136
G1 X138.654 Y110.738 E.09211
G1 X139.034 Y110.738 E.01136
G1 X139.034 Y107.662 E.09211
G1 X139.413 Y107.662 E.01136
G1 X139.413 Y110.738 E.09211
G1 X139.792 Y110.738 E.01136
G1 X139.792 Y107.662 E.09211
G1 X140.171 Y107.662 E.01136
G1 X140.171 Y110.738 E.09211
G1 X140.55 Y110.738 E.01136
G1 X140.55 Y107.662 E.09211
G1 X140.93 Y107.662 E.01136
G1 X140.93 Y110.738 E.09211
G1 X141.309 Y110.738 E.01136
G1 X141.309 Y107.662 E.09211
G1 X141.688 Y107.662 E.01136
G1 X141.688 Y110.738 E.09211
G1 X142.067 Y110.738 E.01136
G1 X142.067 Y107.662 E.09211
G1 X142.446 Y107.662 E.01136
G1 X142.446 Y110.738 E.09211
G1 X142.826 Y110.738 E.01136
G1 X142.826 Y107.662 E.09211
G1 X143.205 Y107.662 E.01136
G1 X143.205 Y110.738 E.09211
G1 X143.584 Y110.738 E.01136
G1 X143.584 Y107.662 E.09211
G1 X143.963 Y107.662 E.01136
G1 X143.963 Y110.738 E.09211
G1 X144.342 Y110.738 E.01136
G1 X144.342 Y107.662 E.09211
G1 X144.721 Y107.662 E.01136
G1 X144.721 Y110.738 E.09211
G1 X145.101 Y110.738 E.01136
G1 X145.101 Y107.662 E.09211
G1 X145.48 Y107.662 E.01136
G1 X145.48 Y110.738 E.09211
G1 X145.859 Y110.738 E.01136
G1 X145.859 Y107.662 E.09211
G1 X146.238 Y107.662 E.01136
G1 X146.238 Y110.738 E.09211
G1 X146.617 Y110.738 E.01136
G1 X146.617 Y107.662 E.09211
G1 X146.997 Y107.662 E.01136
G1 X146.997 Y110.738 E.09211
G1 X147.376 Y110.738 E.01136
G1 X147.376 Y107.662 E.09211
G1 X147.755 Y107.662 E.01136
G1 X147.755 Y110.738 E.09211
G1 X148.134 Y110.738 E.01136
G1 X148.134 Y107.662 E.09211
G1 X148.513 Y107.662 E.01136
G1 X148.513 Y110.738 E.09211
G1 X148.893 Y110.738 E.01136
G1 X148.893 Y107.662 E.09211
G1 X149.272 Y107.662 E.01136
G1 X149.272 Y110.738 E.09211
G1 X149.651 Y110.738 E.01136
G1 X149.651 Y107.662 E.09211
G1 X150.03 Y107.662 E.01136
G1 X150.03 Y110.738 E.09211
G1 X150.409 Y110.738 E.01136
G1 X150.409 Y107.662 E.09211
G1 X150.789 Y107.662 E.01136
G1 X150.789 Y110.738 E.09211
G1 X151.168 Y110.738 E.01136
G1 X151.168 Y107.662 E.09211
G1 X151.547 Y107.662 E.01136
G1 X151.547 Y110.738 E.09211
G1 X151.926 Y110.738 E.01136
G1 X151.926 Y107.662 E.09211
G1 X152.305 Y107.662 E.01136
G1 X152.305 Y110.738 E.09211
G1 X152.684 Y110.738 E.01136
G1 X152.684 Y107.662 E.09211
G1 X153.064 Y107.662 E.01136
G1 X153.064 Y110.907 E.09719
M106 S51
; WIPE_START
G1 X153.064 Y108.907 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.039 Y116.54 Z1.4 F30000
G1 X153.035 Y117.586 Z1.4
G1 Z1
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F3000;_EXTRUDE_SET_SPEED
G1 X153.035 Y111.145 E.17298
; Slow Down End
; WIPE_START
G1 X153.035 Y113.145 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.584 Y117.224 Z1.4 F30000
G1 X140.375 Y121.151 Z1.4
G1 Z1
G1 E.8 F1800
G1 F12000
G1 X140.863 Y121.038 E.01346
G1 X141.311 Y121.059 E.01203
G1 X141.726 Y121.174 E.01156
G3 X142.385 Y121.613 I-.814 J1.937 E.02142
G1 X142.735 Y122.086 E.0158
G1 X142.91 Y122.57 E.01382
G3 X142.68 Y124.016 I-1.953 J.43 E.04025
G1 X142.341 Y124.425 E.01428
G1 X141.86 Y124.768 E.01585
G1 X141.353 Y124.929 E.01429
G3 X140.265 Y124.823 I-.322 J-2.31 E.02963
G1 X139.835 Y124.579 E.01328
G1 X139.648 Y124.425 E.00651
G1 X139.34 Y124.046 E.01312
G1 X139.104 Y123.499 E.01601
G1 X139.044 Y122.996 E.01359
G1 X139.07 Y122.649 E.00934
G1 X139.219 Y122.18 E.01322
G1 X139.555 Y121.682 E.01614
G1 X139.917 Y121.386 E.01257
; WIPE_START
G1 X139.555 Y121.682 E-.1778
G1 X139.219 Y122.18 E-.22829
G1 X139.07 Y122.649 E-.18704
G1 X139.044 Y122.996 E-.13219
G1 X139.055 Y123.087 E-.03469
; WIPE_END
G1 E-.04 F1800
G1 X135.287 Y116.449 Z1.4 F30000
G1 X133.554 Y113.394 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.519665
G1 F12000
G1 X133.554 Y113.922 E.01986
; LINE_WIDTH: 0.480595
G1 X133.554 Y114.449 E.01823
; LINE_WIDTH: 0.441525
G1 X133.554 Y114.977 E.01661
; Slow Down Start
; LINE_WIDTH: 0.421514
G1 F3000;_EXTRUDE_SET_SPEED
G1 X133.554 Y115.504 E.01577
G1 X133.465 Y115.742 E.0076
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.387107
;_EXTRUDE_SET_SPEED
G1 X133.437 Y116.137 E.01078
G1 X133.306 Y116.165 E.00366
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.402455
;_EXTRUDE_SET_SPEED
G1 X132.449 Y116.165 E.02433
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.441525
;_EXTRUDE_SET_SPEED
G1 X131.592 Y116.165 E.02698
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.480595
;_EXTRUDE_SET_SPEED
G1 X130.735 Y116.165 E.02962
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.519665
;_EXTRUDE_SET_SPEED
G1 X129.878 Y116.165 E.03227
; Slow Down End
; WIPE_START
G1 X130.735 Y116.165 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.613 Y112.45 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F12000
G1 X133.613 Y111.694 E.02251
G1 X122.631 Y111.694 E.32712
G1 X122.471 Y111.606 E.00544
G1 X122.442 Y111.114 E.01466
G1 X119.625 Y111.114 E.08391
G3 X119.251 Y111.37 I-1.77 J-2.185 E.01351
G1 X118.994 Y111.38 E.00767
G1 X118.994 Y113.206 E.05437
G1 X133.306 Y113.206 E.42628
; LINE_WIDTH: 0.439859
G1 X133.388 Y113.269 E.00326
; LINE_WIDTH: 0.479595
G1 X133.471 Y113.332 E.00358
; LINE_WIDTH: 0.519332
G1 X133.554 Y113.394 E.00391
G1 X133.574 Y113.229 E.00627
; LINE_WIDTH: 0.479595
G1 X133.593 Y113.064 E.00575
; LINE_WIDTH: 0.425959
G2 X133.613 Y112.51 I-2.294 J-.359 E.0168
G1 X133.236 Y112.45 F30000
; LINE_WIDTH: 0.41999
G1 F12000
G1 X133.236 Y112.071 E.01128
G1 X122.631 Y112.071 E.31589
G1 X122.151 Y111.806 E.01633
G1 X122.051 Y111.492 E.00982
G1 X119.765 Y111.492 E.0681
G1 X119.458 Y111.686 E.0108
G1 X119.371 Y111.682 E.0026
G1 X119.371 Y112.829 E.03415
G1 X133.236 Y112.829 E.41298
G1 X133.236 Y112.51 E.00949
; WIPE_START
G1 X133.236 Y112.829 E-.12111
G1 X131.555 Y112.829 E-.63889
; WIPE_END
G1 E-.04 F1800
G1 X123.929 Y112.505 Z1.4 F30000
G1 X122.631 Y112.45 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.42324
G1 F12000
G1 X132.798 Y112.45 E.30543
; WIPE_START
G1 X130.798 Y112.45 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.165 Y112.45 Z1.4 F30000
G1 X122.631 Y112.45 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.448175
G1 F12000
G1 X122.209 Y112.242 E.01505
; LINE_WIDTH: 0.52052
G1 X121.788 Y112.033 E.01774
G1 X121.756 Y111.92 E.00443
G1 X119.918 Y111.92 E.06932
M73 P34 R10
G1 X119.8 Y111.99 E.00519
G1 X119.8 Y112.4 E.01547
G1 X121.584 Y112.4 E.06733
; LINE_WIDTH: 0.498045
G1 X122.078 Y112.424 E.01775
; LINE_WIDTH: 0.448175
G1 X122.571 Y112.447 E.01581
; WIPE_START
G1 X122.078 Y112.424 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.354 Y116.165 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.38292
G1 F3000;_EXTRUDE_SET_SPEED
G1 X122.037 Y116.165 E.14281
; Slow Down End
; WIPE_START
G1 X124.037 Y116.165 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.375 Y121.151 Z1.4 F30000
G1 Z1
G1 E.8 F1800
G1 F12000
G1 X127.634 Y121.073 E.00726
G1 X128.276 Y121.054 E.01726
G1 X128.726 Y121.174 E.01249
G3 X129.385 Y121.613 I-.814 J1.937 E.02142
G1 X129.735 Y122.086 E.0158
G1 X129.91 Y122.57 E.01382
G3 X129.68 Y124.016 I-1.953 J.43 E.04025
G1 X129.341 Y124.425 E.01428
G1 X128.86 Y124.768 E.01585
G1 X128.429 Y124.918 E.01225
G3 X126.828 Y124.57 I-.41 J-1.974 E.04531
G1 X126.458 Y124.209 E.0139
G1 X126.222 Y123.836 E.01183
G1 X126.073 Y123.368 E.01319
G1 X126.052 Y122.777 E.01589
G1 X126.129 Y122.4 E.01033
G1 X126.333 Y121.966 E.01287
G1 X126.608 Y121.62 E.01189
G1 X126.911 Y121.382 E.01034
; WIPE_START
G1 X126.608 Y121.62 E-.14629
G1 X126.333 Y121.966 E-.16817
G1 X126.129 Y122.4 E-.18215
G1 X126.052 Y122.777 E-.1462
G1 X126.063 Y123.085 E-.1172
; WIPE_END
G1 E-.04 F1800
G1 X129.852 Y129.711 Z1.4 F30000
G1 X134.005 Y136.975 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.005 Y135.347 E.05236
G1 X152.673 Y116.679 E.84891
G1 X152.673 Y119.969 E.10577
G1 X143.833 Y111.13 E.40197
G1 X142.87 Y111.13 E.03097
G1 X130.164 Y123.836 E.57782
G2 X128.44 Y120.718 I-2.188 J-.825 E.13021
G2 X125.837 Y123.837 I-.425 J2.291 E.15865
G1 X118.527 Y116.527 E.33242
G1 X114.445 Y116.527 E.13129
G1 X103.327 Y127.645 E.50556
G1 X103.327 Y124.355 E.10577
G1 X114.173 Y135.2 E.49319
G1 X114.173 Y136.829 E.05236
; WIPE_START
G1 X114.173 Y135.2 E-.61876
G1 X113.91 Y134.938 E-.14124
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I-.51 J1.105 P1  F30000
G1 X133.554 Y143.994 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.519665
G1 F12000
G1 X133.554 Y144.522 E.01986
; LINE_WIDTH: 0.480595
G1 X133.554 Y145.049 E.01823
; LINE_WIDTH: 0.441525
G1 X133.554 Y145.577 E.01661
; Slow Down Start
; LINE_WIDTH: 0.421514
G1 F3000;_EXTRUDE_SET_SPEED
G1 X133.554 Y146.104 E.01577
G1 X133.465 Y146.342 E.0076
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.39916
;_EXTRUDE_SET_SPEED
G1 X133.437 Y146.737 E.01116
G1 X133.306 Y146.765 E.00379
G1 X114.694 Y146.765 E.52373
G1 X114.563 Y146.737 E.00379
G1 X114.535 Y146.606 E.00379
G1 X114.535 Y132.994 E.38302
G1 X114.563 Y132.863 E.00379
G1 X114.694 Y132.835 E.00379
G1 X133.306 Y132.835 E.52373
G1 X133.437 Y132.863 E.00379
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.436467
;_EXTRUDE_SET_SPEED
G1 X133.447 Y132.994 E.00411
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.47756
;_EXTRUDE_SET_SPEED
G1 X133.456 Y133.126 E.00454
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.518654
;_EXTRUDE_SET_SPEED
G1 X133.465 Y133.258 E.00497
; Slow Down End
; Slow Down Start
; LINE_WIDTH: 0.382953
;_EXTRUDE_SET_SPEED
G1 X133.465 Y133.258 E0
; Slow Down End
; LINE_WIDTH: 0.402513
G1 F12000
G1 X133.487 Y133.318 E.0018
; LINE_WIDTH: 0.441567
G1 X133.509 Y133.377 E.002
; LINE_WIDTH: 0.48062
G1 X133.532 Y133.437 E.0022
; LINE_WIDTH: 0.54044
G1 X133.554 Y133.496 E.0025
G1 X133.554 Y135.589 E.08225
; WIPE_START
G1 X133.554 Y133.589 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I-1.217 J.008 P1  F30000
G1 X133.613 Y143.05 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F12000
G1 X133.613 Y142.294 E.02251
G1 X122.631 Y142.294 E.32712
G1 X122.471 Y142.206 E.00544
G1 X122.442 Y141.715 E.01466
G1 X119.625 Y141.715 E.08391
G3 X119.251 Y141.97 I-1.77 J-2.184 E.01351
G1 X118.994 Y141.952 E.00769
G1 X118.994 Y143.806 E.05522
G1 X133.306 Y143.806 E.42628
; LINE_WIDTH: 0.439859
G1 X133.388 Y143.869 E.00326
; LINE_WIDTH: 0.479595
G1 X133.471 Y143.932 E.00358
; LINE_WIDTH: 0.519332
G1 X133.554 Y143.994 E.00391
G1 X133.574 Y143.829 E.00627
; LINE_WIDTH: 0.479595
G1 X133.593 Y143.664 E.00575
; LINE_WIDTH: 0.425959
G2 X133.613 Y143.11 I-2.294 J-.359 E.0168
G1 X133.236 Y143.05 F30000
; LINE_WIDTH: 0.41999
G1 F12000
G1 X133.236 Y142.671 E.01128
G1 X122.631 Y142.671 E.31589
G1 X122.151 Y142.406 E.01633
G1 X122.051 Y142.092 E.00982
G1 X119.765 Y142.092 E.0681
G1 X119.458 Y142.286 E.0108
G1 X119.371 Y142.276 E.00261
G1 X119.371 Y143.429 E.03433
G1 X133.236 Y143.429 E.41298
G1 X133.236 Y143.11 E.00949
; WIPE_START
G1 X133.236 Y143.429 E-.12111
G1 X131.555 Y143.429 E-.63889
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I1.179 J.303 P1  F30000
G1 X133.552 Y135.649 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.522449
G1 F12000
G1 X133.47 Y135.697 E.00361
; LINE_WIDTH: 0.481465
G1 X133.388 Y135.746 E.0033
; LINE_WIDTH: 0.42005
G1 X133.306 Y135.794 E.00284
G1 X118.994 Y135.794 E.42635
G2 X118.997 Y137.663 I149.463 J.716 E.05569
G1 X119.245 Y137.646 E.00741
G3 X119.625 Y137.885 I-.177 J.703 E.01361
G1 X122.442 Y137.885 E.08392
G1 X122.471 Y137.394 E.01466
G1 X122.631 Y137.306 E.00544
G1 X133.613 Y137.306 E.32717
G1 X133.613 Y136.102 E.03586
; LINE_WIDTH: 0.440482
G1 X133.596 Y135.971 E.00416
; LINE_WIDTH: 0.481465
G1 X133.578 Y135.839 E.00459
; LINE_WIDTH: 0.522449
G1 X133.56 Y135.708 E.00502
G1 X133.236 Y136.171 F30000
; LINE_WIDTH: 0.41999
G1 F12000
G1 X119.371 Y136.171 E.41298
G1 X119.371 Y137.315 E.03407
G1 X119.636 Y137.403 E.00833
G1 X119.765 Y137.508 E.00494
G1 X122.065 Y137.508 E.06852
G1 X122.151 Y137.194 E.0097
G1 X122.533 Y136.937 E.01371
G1 X122.631 Y136.929 E.00292
G1 X133.236 Y136.929 E.31589
G1 X133.236 Y136.231 E.02077
; WIPE_START
G1 X133.236 Y136.929 E-.26501
G1 X131.934 Y136.929 E-.49499
; WIPE_END
G1 E-.04 F1800
G1 X124.307 Y136.629 Z1.4 F30000
G1 X122.466 Y136.557 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.423354
G1 F12000
G1 X132.798 Y136.55 E.31046
; WIPE_START
G1 X130.798 Y136.551 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.165 Y136.557 Z1.4 F30000
G1 X122.466 Y136.557 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.4589
G1 F12000
G1 X122.025 Y136.578 E.01451
; LINE_WIDTH: 0.520995
G1 X121.584 Y136.6 E.01667
G1 X119.8 Y136.6 E.0674
G1 X119.8 Y137.015 E.01568
G1 X119.978 Y137.08 E.00717
G1 X121.756 Y137.08 E.06712
G1 X121.788 Y136.967 E.00443
; LINE_WIDTH: 0.50162
G1 X122.102 Y136.778 E.01328
; LINE_WIDTH: 0.4589
G1 X122.415 Y136.588 E.01204
; WIPE_START
G1 X122.102 Y136.778 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I-1.213 J.102 P1  F30000
G1 X122.631 Y143.05 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.42326
G1 F12000
G1 X132.798 Y143.05 E.30545
; WIPE_START
G1 X130.798 Y143.05 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.165 Y143.05 Z1.4 F30000
G1 X122.631 Y143.05 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.448193
G1 F12000
G1 X122.209 Y142.842 E.01505
; LINE_WIDTH: 0.520526
G1 X121.788 Y142.633 E.01774
G1 X121.756 Y142.52 E.00443
G1 X119.918 Y142.52 E.06932
G1 X119.8 Y142.59 E.00519
G1 X119.8 Y143 E.01547
G1 X121.584 Y143 E.06733
; LINE_WIDTH: 0.498058
G1 X122.078 Y143.024 E.01775
; LINE_WIDTH: 0.448193
G1 X122.571 Y143.047 E.01581
; WIPE_START
G1 X122.078 Y143.024 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.64 Y144.055 Z1.4 F30000
G1 X134.005 Y144.651 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X134.005 Y143.022 E.05236
G1 X135.298 Y141.73 E.05879
G1 X136.054 Y141.73 E.02429
G1 X144.697 Y150.373 E.39304
G1 X142.007 Y150.373 E.08648
G1 X150.65 Y141.73 E.39304
G1 X151.406 Y141.73 E.02429
G1 X152.673 Y142.997 E.05762
G1 X152.673 Y147.383 E.14106
G1 X149.683 Y150.373 E.13594
G1 X152.13 Y150.353 E.07867
G2 X152.297 Y150.297 I-.055 J-.44 E.00571
G1 X143.73 Y141.73 E.3896
G1 X142.974 Y141.73 E.02429
G1 X134.331 Y150.373 E.39304
G1 X137.021 Y150.373 E.08648
G1 X133.776 Y147.127 E.14757
G1 X129.9 Y147.127 E.12461
G1 X126.655 Y150.373 E.14757
G1 X129.345 Y150.373 E.08648
G1 X126.1 Y147.127 E.14757
G1 X122.224 Y147.127 E.12461
G1 X118.979 Y150.373 E.14757
G1 X121.669 Y150.373 E.08648
G1 X118.424 Y147.127 E.14757
G1 X114.548 Y147.127 E.12461
G1 X111.303 Y150.373 E.14757
G1 X113.993 Y150.373 E.08648
G1 X105.348 Y141.727 E.39314
G1 X106.976 Y141.727 E.05236
; WIPE_START
G1 X105.348 Y141.727 E-.61876
G1 X105.611 Y141.99 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X104.79 Y134.402 Z1.4 F30000
G1 X102.965 Y117.536 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F12000
G1 X102.967 Y149.663 E.86285
G1 X103.065 Y150.123 E.01264
G1 X103.312 Y150.462 E.01126
G1 X103.665 Y150.671 E.01102
G1 X104.034 Y150.735 E.01008
G1 X151.961 Y150.735 E1.28718
G1 X152.429 Y150.628 E.01291
G1 X152.752 Y150.405 E.01053
G1 X152.974 Y150.026 E.0118
G1 X153.035 Y149.666 E.00979
G1 X153.035 Y141.745 E.21275
; WIPE_START
G1 X153.035 Y143.745 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I1.217 J0 P1  F30000
G1 X153.035 Y137.915 Z1.4
G1 Z1
G1 E.8 F1800
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X153.035 Y118.278 E.52741
; Slow Down End
; WIPE_START
G1 X153.035 Y120.278 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.726 Y118.08 Z1.4 F30000
G1 X113.327 Y108.34 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X113.327 Y109.969 E.05236
G1 X114.172 Y109.124 E.03843
G1 X114.172 Y112.172 E.09804
G1 X113.127 Y111.127 E.04752
G1 X112.169 Y111.127 E.03083
G1 X110.927 Y112.369 E.05644
G1 X110.927 Y113.527 E.03726
G1 X109.769 Y113.527 E.03726
G1 X103.327 Y119.969 E.29292
G1 X103.327 Y116.679 E.10577
G1 X119.121 Y132.473 E.71821
G1 X121.527 Y132.473 E.0774
G1 X128.837 Y125.163 E.33242
G3 X127.171 Y125.171 I-.844 J-2.223 E.05476
G1 X139.87 Y137.87 E.57754
G1 X139.157 Y137.87 E.02293
G1 X152.673 Y124.355 E.61461
G1 X152.673 Y127.645 E.10577
G1 X136.157 Y111.13 E.75104
M73 P35 R10
G1 X135.194 Y111.13 E.03097
G1 X134.005 Y112.319 E.05407
G1 X134.005 Y113.947 E.05236
; WIPE_START
G1 X134.005 Y112.319 E-.61876
G1 X134.268 Y112.056 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X126.641 Y112.326 Z1.4 F30000
G1 X107.435 Y113.006 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.384636
G1 F12000
G1 X107.463 Y113.137 E.00364
G1 X107.594 Y113.165 E.00364
G1 X110.406 Y113.165 E.07588
G1 X110.537 Y113.137 E.00364
G1 X110.565 Y113.006 E.00364
G1 X110.565 Y110.924 E.05619
G1 X110.592 Y110.792 E.00364
G1 X110.724 Y110.765 E.00364
G1 X112.806 Y110.765 E.05619
G1 X112.937 Y110.737 E.00364
G1 X112.965 Y110.606 E.00364
G1 X112.965 Y107.794 E.07588
G1 X112.937 Y107.663 E.00364
G1 X112.806 Y107.635 E.00364
G1 X110.724 Y107.635 E.05619
G1 X110.592 Y107.608 E.00364
G1 X110.565 Y107.476 E.00364
G1 X110.565 Y105.394 E.05619
G1 X110.537 Y105.263 E.00364
G1 X110.406 Y105.235 E.00364
G1 X107.594 Y105.235 E.07588
G1 X107.463 Y105.263 E.00364
G1 X107.435 Y105.394 E.00364
G1 X107.435 Y107.476 E.05619
G1 X107.408 Y107.608 E.00364
G1 X107.276 Y107.635 E.00364
G1 X105.194 Y107.635 E.05619
G1 X105.063 Y107.663 E.00364
G1 X105.035 Y107.794 E.00364
G1 X105.035 Y110.606 E.07588
G1 X105.063 Y110.737 E.00364
G1 X105.194 Y110.765 E.00364
G1 X107.276 Y110.765 E.05619
G1 X107.408 Y110.792 E.00364
G1 X107.435 Y110.924 E.00364
G1 X107.435 Y112.946 E.05457
; WIPE_START
G1 X107.435 Y110.946 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.072 Y111.135 Z1.4 F30000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X105.452 Y111.127 E.05213
G1 X107.072 Y112.748 E.07372
G1 X107.072 Y113.527 E.02505
G1 X107.852 Y113.527 E.02505
G1 X115.004 Y120.68 E.32526
G2 X113.753 Y121.037 I-.032 J2.255 E.04243
G1 X114.029 Y121.313 E.01256
G1 X113.972 Y121.346 E.00215
G1 X113.539 Y121.2 E.0147
G2 X113.709 Y124.939 I1.478 J1.806 E.13968
G1 X103.327 Y135.321 E.47211
G1 X103.327 Y132.031 E.10577
G1 X109.169 Y137.873 E.26563
G1 X108.452 Y137.873 E.02306
G1 X129.797 Y116.527 E.97069
G1 X133.827 Y116.527 E.12962
G1 X133.827 Y116.476 E.00167
G1 X139.067 Y121.715 E.23827
G2 X138.681 Y122.995 I1.84 J1.254 E.04368
G1 X129.203 Y132.473 E.43098
G1 X126.797 Y132.473 E.0774
G1 X117.32 Y122.996 E.43096
G2 X116.933 Y121.715 I-2.605 J.087 E.04352
G1 X122.121 Y116.527 E.2359
G1 X126.203 Y116.527 E.13129
G1 X147.546 Y137.87 E.97059
G1 X146.833 Y137.87 E.02293
G1 X152.673 Y132.031 E.26554
G1 X152.673 Y135.321 E.10577
G1 X142.287 Y124.935 E.47231
G2 X140.996 Y120.68 I-1.3 J-1.929 E.19034
G1 X150.546 Y111.13 E.43429
G1 X151.509 Y111.13 E.03097
G1 X152.673 Y112.293 E.0529
G1 X152.673 Y113.921 E.05236
; WIPE_START
G1 X152.673 Y112.293 E-.61876
G1 X152.41 Y112.03 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X144.783 Y112.324 Z1.4 F30000
G1 X103.327 Y113.921 Z1.4
G1 Z1
G1 E.8 F1800
G1 F15476.087
G1 X103.327 Y112.293 E.05236
G1 X104.672 Y110.948 E.06117
G1 X104.672 Y110.348 E.01927
G1 X103.327 Y109.003 E.06117
G1 X103.327 Y104.617 E.14106
G1 X106.317 Y101.628 E.13594
G1 X103.855 Y101.649 E.07917
G2 X103.703 Y101.703 I.076 J.449 E.0052
G1 X107.072 Y105.072 E.15322
G1 X107.072 Y104.872 E.00643
G1 X110.748 Y104.872 E.11818
G1 X113.992 Y101.628 E.14755
G1 X111.304 Y101.628 E.08645
G1 X114.172 Y104.497 E.13046
G1 X114.172 Y102.868 E.05236
; WIPE_START
G1 X114.172 Y104.497 E-.61876
G1 X113.91 Y104.234 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X108.9 Y109.992 Z1.4 F30000
G1 X102.965 Y116.816 Z1.4
G1 Z1
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F3000;_EXTRUDE_SET_SPEED
G1 X102.965 Y102.332 E.389
G1 X103.046 Y101.917 E.01137
G1 X103.274 Y101.57 E.01114
G1 X103.624 Y101.35 E.01113
G1 X104.039 Y101.265 E.01138
G1 X115.615 Y101.265 E.3109
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X113.615 Y101.265 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 6/22
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
G17
G3 Z1.4 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X118.602 Y113.598
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.602 Y104.802 E.28284
G1 X122.855 Y104.802 E.13675
G1 X122.855 Y113.598 E.28284
G1 X118.662 Y113.598 E.13482
; WIPE_START
G1 X118.648 Y111.598 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.638 Y119.23 Z1.6 F30000
G1 X118.602 Y144.198 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F15476.087
G1 X118.602 Y135.402 E.28284
G1 X122.855 Y135.402 E.13675
G1 X122.855 Y144.198 E.28284
G1 X118.662 Y144.198 E.13482
; WIPE_START
G1 X118.648 Y142.198 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I1.131 J.45 P1  F30000
G1 X126.585 Y122.257 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F15476.087
G1 X126.607 Y122.207 E.00173
G3 X127.765 Y121.415 I1.39 J.788 E.04673
G1 X127.912 Y121.4 E.00476
G3 X126.47 Y122.524 I.084 J1.596 E.26021
G1 X126.562 Y122.312 E.00744
M204 S250
G1 X126.944 Y122.412 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.949 Y122.397 E.00046
G3 X127.821 Y121.803 I1.047 J.599 E.03254
G1 X127.931 Y121.792 E.00329
G3 X126.843 Y122.642 I.064 J1.204 E.18195
G1 X126.92 Y122.467 E.00569
; WIPE_START
M204 S10000
G1 X126.949 Y122.397 E-.02869
G1 X127.054 Y122.245 E-.07014
G1 X127.177 Y122.113 E-.06867
G1 X127.395 Y121.952 E-.10305
G1 X127.643 Y121.844 E-.10291
G1 X127.821 Y121.803 E-.06933
G1 X127.931 Y121.792 E-.04199
G1 X128.18 Y121.803 E-.09484
G1 X128.442 Y121.873 E-.10295
G1 X128.606 Y121.953 E-.06928
G1 X128.624 Y121.965 E-.00815
; WIPE_END
G1 E-.04 F1800
G1 X136.249 Y122.297 Z1.6 F30000
G1 X142.537 Y122.57 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.559 Y122.644 E.00248
G3 X140.765 Y121.415 I-1.562 J.356 E.2468
G1 X140.912 Y121.4 E.00476
G3 X142.441 Y122.306 I.085 J1.6 E.06056
G1 X142.516 Y122.514 E.00712
M204 S250
G1 X142.169 Y122.699 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.175 Y122.732 E.00099
G3 X140.821 Y121.803 I-1.18 J.268 E.17264
G1 X140.931 Y121.792 E.00329
G3 X142.086 Y122.477 I.065 J1.208 E.0424
G1 X142.148 Y122.643 E.00528
; WIPE_START
M204 S10000
G1 X142.175 Y122.732 E-.03533
G1 X142.207 Y122.911 E-.06908
G1 X142.197 Y123.177 E-.10115
G1 X142.156 Y123.357 E-.07009
G1 X142.048 Y123.605 E-.10296
G1 X141.945 Y123.756 E-.0693
G1 X141.757 Y123.944 E-.10116
G1 X141.525 Y124.09 E-.10425
G1 X141.269 Y124.18 E-.10296
G1 X141.26 Y124.181 E-.00373
; WIPE_END
G1 E-.04 F1800
G1 X134.027 Y121.744 Z1.6 F30000
G1 X116.398 Y115.802 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.04823
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y102.882 E.00914
G1 X133.578 Y102.882 E.0153
G1 X133.578 Y115.518 E.40632
G1 X133.102 Y115.518 E.0153
G1 X133.102 Y115.802 E.00914
G1 X116.458 Y115.802 E.53521
; WIPE_START
G1 X114.898 Y115.802 E-.5928
G1 X114.898 Y115.362 E-.1672
; WIPE_END
G1 E-.04 F1800
G1 X118.21 Y113.99 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y113.99 E.43191
G1 X132.71 Y115.41 E.0423
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y104.41 E.0423
G1 X118.21 Y104.41 E.43191
G1 X118.21 Y113.93 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y113.938 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.647 Y110.043 Z1.6 F30000
G1 X110.202 Y107.998 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.222 Y115.621 Z1.6 F30000
G1 X116.535 Y122.566 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.559 Y122.644 E.00263
G3 X114.765 Y121.415 I-1.562 J.356 E.2468
G1 X114.912 Y121.4 E.00476
G3 X116.441 Y122.306 I.085 J1.6 E.06056
G1 X116.515 Y122.509 E.00696
M204 S250
G1 X116.167 Y122.695 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.175 Y122.732 E.00113
G3 X114.821 Y121.803 I-1.18 J.268 E.17264
G1 X114.931 Y121.792 E.00329
G3 X116.086 Y122.477 I.065 J1.208 E.0424
G1 X116.146 Y122.638 E.00513
; WIPE_START
M204 S10000
G1 X116.175 Y122.732 E-.03718
G1 X116.207 Y122.911 E-.06908
G1 X116.197 Y123.177 E-.10115
G1 X116.156 Y123.357 E-.07009
G1 X116.048 Y123.605 E-.10296
G1 X115.945 Y123.756 E-.0693
G1 X115.757 Y123.944 E-.10116
G1 X115.525 Y124.09 E-.10425
G1 X115.269 Y124.18 E-.10296
G1 X115.264 Y124.181 E-.00187
; WIPE_END
G1 E-.04 F1800
G1 X115.653 Y131.803 Z1.6 F30000
G1 X116.398 Y146.402 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.04824
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y133.482 E.00914
G1 X133.578 Y133.482 E.0153
G1 X133.578 Y146.118 E.40632
G1 X133.102 Y146.118 E.0153
G1 X133.102 Y146.402 E.00914
G1 X116.458 Y146.402 E.53521
; WIPE_START
G1 X114.898 Y146.402 E-.59281
G1 X114.898 Y145.962 E-.16719
; WIPE_END
M73 P36 R10
G1 E-.04 F1800
G1 X118.21 Y144.59 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.71 Y144.59 E.43191
G1 X132.71 Y146.01 E.0423
G1 X115.29 Y146.01 E.51888
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y135.01 E.0423
G1 X118.21 Y135.01 E.43191
G1 X118.21 Y144.53 E.28357
; WIPE_START
M204 S10000
G1 X120.21 Y144.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.153 Y141.631 Z1.6 F30000
G1 X105.79 Y138.598 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.191 Y140.897 Z1.6 F30000
G1 X153.167 Y150.467 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X151.989 Y151.098 I-1.171 J-.771 E.04478
G1 X104.011 Y151.098 E1.5428
G3 X102.602 Y149.689 I-.009 J-1.4 E.07129
G1 X102.602 Y102.311 E1.52352
G3 X104.011 Y100.902 I1.402 J-.007 E.07126
G1 X152.058 Y100.905 E1.54501
G3 X153.398 Y102.311 I-.067 J1.405 E.06895
G1 X153.398 Y149.689 E1.52352
G3 X153.199 Y150.417 I-1.402 J.007 E.02456
M204 S250
G1 X153.497 Y150.679 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.501 J-.983 E.05296
G1 X104.004 Y151.49 E1.42952
G3 X102.21 Y149.696 I-.002 J-1.792 E.08396
G1 X102.21 Y102.304 E1.41166
G3 X104.004 Y100.51 I1.794 J0 E.08393
G1 X152.072 Y100.513 E1.43178
G3 X153.79 Y102.304 I-.083 J1.799 E.08156
G1 X153.79 Y149.696 E1.41166
G3 X153.529 Y150.628 I-1.794 J0 E.02919
; WIPE_START
M204 S10000
G1 X153.292 Y150.939 E-.14853
G1 X152.99 Y151.191 E-.14925
G1 X152.708 Y151.343 E-.12204
G1 X152.39 Y151.447 E-.12674
G1 X151.996 Y151.49 E-.15078
G1 X151.831 Y151.49 E-.06267
; WIPE_END
G1 E-.04 F1800
G1 X152.195 Y143.866 Z1.6 F30000
G1 X152.337 Y140.873 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40052
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X153.028 Y141.564 E.04862
G1 X153.028 Y142.201 E.03171
G1 X151.903 Y141.076 E.0792
G1 X151.266 Y141.076 E.0317
G1 X153.028 Y142.838 E.12404
M73 P36 R9
G1 X153.028 Y143.476 E.0317
G1 X150.629 Y141.076 E.16888
G1 X149.991 Y141.076 E.0317
G1 X153.028 Y144.113 E.21372
G1 X153.028 Y144.75 E.0317
G1 X149.354 Y141.076 E.25855
G1 X148.717 Y141.076 E.0317
G1 X153.028 Y145.387 E.30339
G1 X153.028 Y146.024 E.0317
G1 X148.08 Y141.076 E.34823
G1 X147.443 Y141.076 E.0317
G1 X153.028 Y146.661 E.39307
G1 X153.028 Y147.298 E.03171
G1 X146.806 Y141.076 E.4379
G1 X146.169 Y141.076 E.03171
G1 X153.028 Y147.936 E.48274
G1 X153.028 Y148.573 E.0317
G1 X145.532 Y141.076 E.52758
G1 X144.894 Y141.076 E.0317
G1 X153.028 Y149.21 E.57242
G3 X153.012 Y149.83 I-2.994 J.23 E.03094
G1 X144.257 Y141.076 E.61608
G1 X143.62 Y141.076 E.0317
G1 X152.836 Y150.291 E.64852
G3 X152.499 Y150.592 I-.945 J-.718 E.02259
G1 X142.983 Y141.076 E.66968
G1 X142.346 Y141.076 E.0317
G1 X151.995 Y150.725 E.67908
G1 X151.361 Y150.728 E.03156
G1 X141.709 Y141.076 E.67928
G1 X141.072 Y141.076 E.0317
G1 X150.724 Y150.728 E.67928
G1 X150.087 Y150.728 E.0317
G1 X140.434 Y141.076 E.67928
G1 X139.797 Y141.076 E.0317
G1 X149.45 Y150.728 E.67928
G1 X148.813 Y150.728 E.0317
G1 X139.16 Y141.076 E.67928
G1 X138.523 Y141.076 E.0317
G1 X148.175 Y150.728 E.67928
G1 X147.538 Y150.728 E.0317
G1 X137.886 Y141.076 E.67928
G1 X137.249 Y141.076 E.0317
G1 X146.901 Y150.728 E.67928
G1 X146.264 Y150.728 E.0317
G1 X136.612 Y141.076 E.67928
G1 X135.975 Y141.076 E.0317
G1 X145.627 Y150.728 E.67928
M73 P37 R9
G1 X144.99 Y150.728 E.0317
G1 X135.337 Y141.076 E.67928
G1 X134.7 Y141.076 E.03171
G1 X144.353 Y150.728 E.67928
G1 X143.716 Y150.728 E.0317
G1 X134.063 Y141.076 E.67928
G1 X133.947 Y141.076 E.00576
G1 X133.947 Y141.597 E.02594
G1 X143.078 Y150.728 E.64259
G1 X142.441 Y150.728 E.03171
G1 X133.947 Y142.234 E.59775
G1 X133.947 Y142.872 E.0317
G1 X141.804 Y150.728 E.55291
G1 X141.167 Y150.728 E.0317
G1 X133.947 Y143.509 E.50807
G1 X133.947 Y144.146 E.0317
G1 X140.53 Y150.728 E.46324
G1 X139.893 Y150.728 E.0317
G1 X133.947 Y144.783 E.4184
G1 X133.947 Y145.42 E.0317
G1 X139.256 Y150.728 E.37356
G1 X138.619 Y150.728 E.0317
G1 X133.947 Y146.057 E.32872
G1 X133.947 Y146.487 E.02141
G1 X133.741 Y146.487 E.01029
G1 X137.981 Y150.728 E.29844
G1 X137.344 Y150.728 E.0317
G1 X133.388 Y146.772 E.27844
G1 X132.751 Y146.772 E.0317
G1 X136.707 Y150.728 E.27844
G1 X136.07 Y150.728 E.0317
G1 X132.113 Y146.772 E.27844
G1 X131.476 Y146.772 E.0317
G1 X135.433 Y150.728 E.27844
G1 X134.796 Y150.728 E.0317
G1 X130.839 Y146.772 E.27844
G1 X130.202 Y146.772 E.03171
G1 X134.159 Y150.728 E.27844
G1 X133.521 Y150.728 E.0317
G1 X129.565 Y146.772 E.27844
G1 X128.928 Y146.772 E.0317
G1 X132.884 Y150.728 E.27844
G1 X132.247 Y150.728 E.0317
G1 X128.291 Y146.772 E.27844
G1 X127.653 Y146.772 E.0317
G1 X131.61 Y150.728 E.27844
G1 X130.973 Y150.728 E.03171
G1 X127.016 Y146.772 E.27844
G1 X126.379 Y146.772 E.0317
G1 X130.336 Y150.728 E.27844
G1 X129.699 Y150.728 E.0317
G1 X125.742 Y146.772 E.27844
G1 X125.105 Y146.772 E.0317
G1 X129.062 Y150.728 E.27844
G1 X128.424 Y150.728 E.0317
G1 X124.468 Y146.772 E.27844
G1 X123.831 Y146.772 E.0317
G1 X127.787 Y150.728 E.27844
G1 X127.15 Y150.728 E.0317
G1 X123.194 Y146.772 E.27844
G1 X122.556 Y146.772 E.0317
G1 X126.513 Y150.728 E.27844
G1 X125.876 Y150.728 E.0317
G1 X121.919 Y146.772 E.27844
G1 X121.282 Y146.772 E.0317
G1 X125.239 Y150.728 E.27844
G1 X124.602 Y150.728 E.0317
G1 X120.645 Y146.772 E.27844
G1 X120.008 Y146.772 E.0317
G1 X123.964 Y150.728 E.27844
G1 X123.327 Y150.728 E.0317
G1 X119.371 Y146.772 E.27844
G1 X118.734 Y146.772 E.03171
G1 X122.69 Y150.728 E.27844
G1 X122.053 Y150.728 E.03171
G1 X118.096 Y146.772 E.27844
G1 X117.459 Y146.772 E.0317
G1 X121.416 Y150.728 E.27844
G1 X120.779 Y150.728 E.0317
G1 X116.822 Y146.772 E.27844
G1 X116.185 Y146.772 E.0317
G1 X120.142 Y150.728 E.27844
G1 X119.505 Y150.728 E.0317
G1 X115.345 Y146.569 E.29269
M106 S51
; WIPE_START
G1 X116.76 Y147.983 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.543 Y140.877 Z1.6 F30000
G1 X120.936 Y137.321 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45748
; LAYER_HEIGHT: 0.2
G1 F15000
G1 X120.521 Y137.321 E.01358
G1 X120.521 Y142.279 E.16235
G1 X120.936 Y142.279 E.01358
G1 X120.936 Y137.381 E.16039
G1 X121.332 Y136.925 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X120.125 Y136.925 E.03593
G1 X120.125 Y142.675 E.17125
G1 X121.332 Y142.675 E.03593
G1 X121.332 Y136.985 E.16946
G1 X121.709 Y136.548 F30000
G1 F15000
G1 X119.748 Y136.548 E.05839
G1 X119.748 Y143.052 E.19371
G1 X121.709 Y143.052 E.05839
G1 X121.709 Y136.608 E.19192
G1 X122.086 Y136.171 F30000
G1 F15000
G1 X119.371 Y136.171 E.08085
G1 X119.371 Y143.429 E.21617
G1 X122.086 Y143.429 E.08085
G1 X122.086 Y136.231 E.21439
G1 X122.463 Y135.794 F30000
G1 F15000
G1 X118.994 Y135.794 E.10332
G1 X118.994 Y143.806 E.23864
G1 X122.463 Y143.806 E.10332
G1 X122.463 Y135.854 E.23685
; WIPE_START
G1 X122.463 Y137.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.616 Y135.191 Z1.6 F30000
G1 X133.171 Y133.868 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.50814
G1 F13541.982
G2 X133.169 Y133.969 I-.029 J.05 E.00882
G1 X133.745 Y133.749 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.40052
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X138.52 Y138.524 E.33603
G1 X137.883 Y138.524 E.0317
G1 X133.947 Y134.589 E.27694
G1 X133.947 Y135.226 E.0317
G1 X137.246 Y138.524 E.23211
G1 X136.608 Y138.524 E.0317
G1 X133.947 Y135.863 E.18727
G1 X133.947 Y136.5 E.0317
G1 X135.971 Y138.524 E.14243
G1 X135.334 Y138.524 E.0317
G1 X133.947 Y137.137 E.09759
G1 X133.947 Y137.774 E.0317
G1 X134.697 Y138.524 E.05276
G1 X134.06 Y138.524 E.0317
G1 X133.745 Y138.209 E.02217
M106 S51
; WIPE_START
G1 X134.06 Y138.524 E-.16929
G1 X134.697 Y138.524 E-.24211
G1 X134.048 Y137.875 E-.3486
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-1.127 J.459 P1  F30000
G1 X134.832 Y139.8 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.63658
; LAYER_HEIGHT: 0.2
G1 F10612.135
G1 X152.083 Y139.8 E.80899
; WIPE_START
G1 X150.083 Y139.8 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I.038 J-1.216 P1  F30000
G1 X134.347 Y139.315 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F15000
G1 X134.347 Y140.285 E.02891
G1 X152.629 Y140.285 E.54454
G1 X152.629 Y139.315 E.02891
G1 X134.407 Y139.315 E.54275
M73 P38 R9
G1 X133.97 Y138.938 F30000
G1 F15000
G1 X133.97 Y140.662 E.05138
G1 X153.006 Y140.662 E.567
G1 X153.006 Y138.938 E.05138
G1 X134.03 Y138.938 E.56522
; WIPE_START
G1 X136.03 Y138.938 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-1.095 J-.532 P1  F30000
G1 X132.917 Y145.346 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
M204 S2000
G1 X133.355 Y144.908 E.01845
G1 X133.355 Y144.375
G1 X132.917 Y144.812 E.01845
G1 X132.814 Y144.383
G1 X133.355 Y143.841 E.0228
G1 X133.355 Y143.308
G1 X132.281 Y144.383 E.04526
G1 X131.747 Y144.383
G1 X133.355 Y142.775 E.06773
G1 X133.355 Y142.242
G1 X131.214 Y144.383 E.09019
G1 X130.681 Y144.383
G1 X133.355 Y141.708 E.11265
G1 X133.355 Y141.175
G1 X130.148 Y144.383 E.13512
G1 X129.614 Y144.383
G1 X133.355 Y140.642 E.15758
G1 X133.355 Y140.109
G1 X129.081 Y144.383 E.18004
G1 X128.548 Y144.383
G1 X133.355 Y139.575 E.20251
G1 X133.355 Y139.042
G1 X128.015 Y144.383 E.22497
G1 X127.481 Y144.383
G1 X133.355 Y138.509 E.24743
G1 X133.355 Y137.976
G1 X126.948 Y144.383 E.2699
G1 X126.415 Y144.383
G1 X133.355 Y137.442 E.29236
G1 X133.355 Y136.909
G1 X125.882 Y144.383 E.31482
G1 X125.348 Y144.383
G1 X133.355 Y136.376 E.33729
G1 X133.355 Y135.842
G1 X124.815 Y144.383 E.35975
G1 X124.282 Y144.383
G1 X133.355 Y135.309 E.38221
G1 X132.917 Y135.214
G1 X133.355 Y134.776 E.01845
G1 X133.327 Y134.271
G1 X132.917 Y134.681 E.01725
G1 X132.914 Y135.217
G1 X123.749 Y144.383 E.38608
G1 X123.215 Y144.383
G1 X132.381 Y135.217 E.38608
G1 X131.847 Y135.217
G1 X123.077 Y143.987 E.36943
G1 X123.077 Y143.454
G1 X131.314 Y135.217 E.34697
G1 X130.781 Y135.217
G1 X123.077 Y142.921 E.32451
G1 X123.077 Y142.388
G1 X130.248 Y135.217 E.30205
G1 X129.714 Y135.217
G1 X123.077 Y141.854 E.27958
G1 X123.077 Y141.321
G1 X129.181 Y135.217 E.25712
G1 X128.648 Y135.217
G1 X123.077 Y140.788 E.23466
G1 X123.077 Y140.255
G1 X128.115 Y135.217 E.21219
G1 X127.581 Y135.217
G1 X123.077 Y139.721 E.18973
G1 X123.077 Y139.188
G1 X127.048 Y135.217 E.16727
G1 X126.515 Y135.217
G1 X123.077 Y138.655 E.1448
G1 X123.077 Y138.122
G1 X125.982 Y135.217 E.12234
G1 X125.448 Y135.217
G1 X123.077 Y137.588 E.09988
G1 X123.077 Y137.055
G1 X124.915 Y135.217 E.07741
G1 X124.382 Y135.217
G1 X123.077 Y136.522 E.05495
G1 X123.077 Y135.989
G1 X123.848 Y135.217 E.03249
; WIPE_START
M204 S10000
G1 X123.077 Y135.989 E-.41444
G1 X123.077 Y136.522 E-.20264
G1 X123.343 Y136.256 E-.14292
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-.812 J.906 P1  F30000
G1 X133.374 Y145.242 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.15088
G1 F15000
G1 X133.308 Y145.297 E.00073
; LINE_WIDTH: 0.134232
G1 X133.229 Y145.352 E.0007
; LINE_WIDTH: 0.103527
G1 X133.149 Y145.407 E.00046
; WIPE_START
G1 X133.229 Y145.352 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.31 Y142.504 Z1.6 F30000
G1 X153.231 Y137.307 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40052
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X140.891 Y124.967 E.86842
G2 X141.467 Y124.906 I.078 J-2.029 E.02894
G1 X153.028 Y136.467 E.8136
G1 X153.028 Y135.83 E.0317
G1 X141.933 Y124.735 E.78082
G2 X142.306 Y124.471 I-1.018 J-1.834 E.02279
G1 X153.028 Y135.193 E.75457
G1 X153.028 Y134.556 E.0317
G1 X142.607 Y124.135 E.73335
G2 X142.827 Y123.718 I-.988 J-.788 E.02361
G1 X153.028 Y133.919 E.71787
G1 X153.028 Y133.282 E.0317
G1 X148.924 Y129.177 E.28885
G1 X149.264 Y129.177 E.01691
G1 X148.681 Y128.594 E.04099
G1 X148.511 Y128.764 E.01196
G1 X142.959 Y123.212 E.39076
G2 X142.902 Y122.518 I-1.948 J-.191 E.03481
G1 X153.028 Y132.644 E.71262
G1 X153.028 Y132.007 E.0317
G1 X133.947 Y112.926 E1.3428
G1 X133.947 Y113.563 E.0317
G1 X141.47 Y121.086 E.52936
G2 X141.047 Y121.033 I-.507 J2.374 E.02122
G1 X140.791 Y121.044 E.01277
G1 X137.349 Y117.602 E.24221
G1 X137.891 Y117.602 E.02698
G1 X137.268 Y116.979 E.04381
G1 X136.997 Y117.25 E.01908
M73 P39 R9
G1 X133.947 Y114.201 E.21463
G1 X133.947 Y114.838 E.0317
G1 X139.898 Y120.788 E.41877
G1 X139.898 Y121.375 E.02918
G1 X139.869 Y121.396 E.0018
G1 X133.947 Y115.475 E.41671
G1 X133.947 Y115.887 E.02053
G1 X133.723 Y115.887 E.01117
G1 X139.532 Y121.696 E.40878
G2 X139.274 Y122.067 I.723 J.777 E.02262
G1 X133.37 Y116.172 E.41517
G1 X132.733 Y116.172 E.0317
G1 X139.087 Y122.526 E.44718
G2 X139.038 Y123.042 I1.921 J.443 E.02585
G1 X139.041 Y123.117 E.00375
G1 X132.096 Y116.172 E.48876
G1 X131.459 Y116.172 E.0317
G1 X153.028 Y137.741 E1.51794
G1 X153.028 Y138.379 E.0317
G1 X130.821 Y116.172 E1.56278
G1 X130.184 Y116.172 E.0317
G1 X152.537 Y138.524 E1.57303
G1 X151.9 Y138.524 E.0317
G1 X129.726 Y116.35 E1.56045
G1 X129.407 Y116.669 E.02242
G1 X151.262 Y138.524 E1.53803
G1 X150.625 Y138.524 E.03171
G1 X129.089 Y116.988 E1.51561
G1 X128.77 Y117.306 E.02242
G1 X149.988 Y138.524 E1.49319
G1 X149.351 Y138.524 E.0317
G1 X126.999 Y116.172 E1.57303
G1 X126.362 Y116.172 E.0317
G1 X148.714 Y138.524 E1.57303
G1 X148.077 Y138.524 E.0317
G1 X125.724 Y116.172 E1.57303
G1 X125.087 Y116.172 E.03171
G1 X147.44 Y138.524 E1.57303
G1 X146.803 Y138.524 E.03171
G1 X124.248 Y115.969 E1.58728
M106 S51
; WIPE_START
G1 X125.662 Y117.383 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.361 Y116.302 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.63546
; LAYER_HEIGHT: 0.2
G1 F10632.195
G1 X120.859 Y116.302 E.02352
; WIPE_START
G1 X121.361 Y116.302 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.513 Y115.969 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40052
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X126.111 Y123.567 E.53468
G1 X126.047 Y123.287 E.01428
G1 X126.031 Y122.85 E.02177
M73 P40 R9
G1 X119.353 Y116.172 E.46998
G1 X119.657 Y116.172 E.01513
G1 X120.641 Y116.822 E.05867
G1 X126.15 Y122.332 E.38774
G3 X126.363 Y121.908 I1.22 J.348 E.02375
G1 X121.428 Y116.972 E.34733
G1 X121.747 Y116.654 E.02242
G1 X126.652 Y121.56 E.34524
G1 X126.898 Y121.375 E.0153
G1 X126.898 Y121.168 E.01028
G1 X122.036 Y116.306 E.34219
G1 X122.042 Y116.172 E.00667
G1 X122.539 Y116.172 E.02471
G1 X127.47 Y121.103 E.34702
G3 X128.038 Y121.034 I.469 J1.491 E.02864
G1 X123.176 Y116.172 E.34217
G1 X123.813 Y116.172 E.0317
G1 X146.165 Y138.524 E1.57303
G1 X145.528 Y138.524 E.0317
G1 X129.968 Y122.964 E1.09503
G3 X129.932 Y123.378 I-1.823 J.048 E.02075
G1 X129.897 Y123.53 E.00775
G1 X144.891 Y138.524 E1.05518
G1 X144.254 Y138.524 E.0317
G1 X129.712 Y123.982 E1.02338
G3 X129.434 Y124.342 I-1.107 J-.567 E.02273
G1 X143.617 Y138.524 E.99808
G1 X142.98 Y138.524 E.0317
G1 X129.092 Y124.637 E.97732
G3 X128.714 Y124.84 I-.855 J-1.137 E.02143
G1 X128.67 Y124.852 E.00228
G1 X142.343 Y138.524 E.96218
G1 X141.705 Y138.524 E.0317
G1 X128.143 Y124.961 E.95447
G3 X127.433 Y124.889 I-.161 J-1.937 E.03569
G1 X141.068 Y138.524 E.95956
G1 X140.431 Y138.524 E.0317
G1 X118.079 Y116.172 E1.57303
G1 X117.442 Y116.172 E.0317
G1 X139.794 Y138.524 E1.57303
G1 X139.157 Y138.524 E.03171
G1 X116.805 Y116.172 E1.57303
G1 X116.167 Y116.172 E.0317
G1 X132.824 Y132.828 E1.17219
G1 X132.187 Y132.828 E.0317
G1 X115.328 Y115.969 E1.18644
M106 S51
; WIPE_START
G1 X116.742 Y117.383 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.936 Y111.679 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.45748
; LAYER_HEIGHT: 0.2
G1 F15000
G1 X120.936 Y106.721 E.16235
G1 X120.521 Y106.721 E.01358
G1 X120.521 Y111.679 E.16235
G1 X120.876 Y111.679 E.01161
G1 X121.332 Y112.075 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X121.332 Y106.325 E.17125
G1 X120.125 Y106.325 E.03593
G1 X120.125 Y112.075 E.17125
G1 X121.272 Y112.075 E.03414
G1 X121.709 Y112.452 F30000
G1 F15000
G1 X121.709 Y105.948 E.19371
G1 X119.748 Y105.948 E.05839
G1 X119.748 Y112.452 E.19371
G1 X121.649 Y112.452 E.0566
G1 X122.086 Y112.829 F30000
G1 F15000
G1 X122.086 Y105.571 E.21617
G1 X119.371 Y105.571 E.08085
G1 X119.371 Y112.829 E.21617
G1 X122.026 Y112.829 E.07907
G1 X122.463 Y113.206 F30000
G1 F15000
G1 X122.463 Y105.194 E.23864
G1 X118.994 Y105.194 E.10332
G1 X118.994 Y113.206 E.23864
G1 X122.403 Y113.206 E.10153
; WIPE_START
G1 X120.403 Y113.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.587 Y115.782 Z1.6 F30000
G1 X129.037 Y116.302 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.63546
G1 F10632.195
G1 X128.195 Y116.302 E.03943
; WIPE_START
M73 P41 R9
G1 X129.037 Y116.302 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.917 Y114.417 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
M204 S2000
G1 X133.355 Y113.979 E.01845
G1 X133.355 Y113.446
G1 X132.917 Y113.884 E.01845
G1 X132.485 Y113.783
G1 X133.355 Y112.912 E.03666
G1 X133.355 Y112.379
G1 X131.952 Y113.783 E.05912
G1 X131.419 Y113.783
G1 X133.355 Y111.846 E.08158
G1 X133.355 Y111.313
G1 X130.885 Y113.783 E.10405
G1 X130.352 Y113.783
G1 X133.355 Y110.779 E.12651
G1 X133.355 Y110.246
G1 X129.819 Y113.783 E.14897
G1 X129.286 Y113.783
G1 X133.355 Y109.713 E.17144
G1 X133.355 Y109.18
G1 X128.752 Y113.783 E.1939
G1 X128.219 Y113.783
G1 X133.355 Y108.646 E.21636
G1 X133.355 Y108.113
G1 X127.686 Y113.783 E.23883
G1 X127.153 Y113.783
G1 X133.355 Y107.58 E.26129
G1 X133.355 Y107.047
G1 X126.619 Y113.783 E.28375
G1 X126.086 Y113.783
G1 X133.355 Y106.513 E.30622
G1 X133.355 Y105.98
G1 X125.553 Y113.783 E.32868
G1 X125.019 Y113.783
G1 X133.355 Y105.447 E.35114
G1 X133.355 Y104.914
G1 X124.486 Y113.783 E.3736
G1 X123.953 Y113.783
G1 X133.355 Y104.38 E.39607
G1 X132.917 Y104.285
G1 X133.355 Y103.847 E.01845
G1 X132.585 Y104.617
G1 X123.42 Y113.783 E.38608
G1 X123.077 Y113.592
G1 X132.052 Y104.617 E.37804
G1 X131.518 Y104.617
G1 X123.077 Y113.059 E.35558
G1 X123.077 Y112.525
G1 X130.985 Y104.617 E.33312
G1 X130.452 Y104.617
G1 X123.077 Y111.992 E.31065
G1 X123.077 Y111.459
G1 X129.919 Y104.617 E.28819
G1 X129.385 Y104.617
G1 X123.077 Y110.925 E.26573
G1 X123.077 Y110.392
G1 X128.852 Y104.617 E.24326
G1 X128.319 Y104.617
G1 X123.077 Y109.859 E.2208
G1 X123.077 Y109.326
G1 X127.786 Y104.617 E.19834
G1 X127.252 Y104.617
G1 X123.077 Y108.792 E.17587
G1 X123.077 Y108.259
G1 X126.719 Y104.617 E.15341
G1 X126.186 Y104.617
G1 X123.077 Y107.726 E.13095
G1 X123.077 Y107.193
G1 X125.653 Y104.617 E.10848
G1 X125.119 Y104.617
G1 X123.077 Y106.659 E.08602
G1 X123.077 Y106.126
G1 X124.586 Y104.617 E.06356
G1 X124.053 Y104.617
G1 X123.077 Y105.593 E.04109
G1 X123.077 Y105.06
G1 X123.52 Y104.617 E.01863
; WIPE_START
M204 S10000
G1 X123.077 Y105.06 E-.23768
G1 X123.077 Y105.593 E-.20264
G1 X123.672 Y104.998 E-.31968
; WIPE_END
G1 E-.04 F1800
G1 X131.244 Y104.035 Z1.6 F30000
G1 X133.374 Y103.764 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.164473
G1 F15000
G2 X133.179 Y103.652 I-.211 J.143 E.00224
; LINE_WIDTH: 0.20109
G1 X132.899 Y103.704 E.00356
G1 X133.171 Y103.268 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.50814
G1 F13541.982
G2 X133.169 Y103.369 I-.029 J.05 E.00882
G1 X132.86 Y102.431 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.40779
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X131.5 Y101.071 E.09923
M106 S51
G1 X131.312 Y101.296 F30000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F12000
G1 X116.088 Y101.295 E.45347
G1 X116.586 Y102.206 E.03094
G1 X131.81 Y102.206 E.45345
G1 X131.341 Y101.348 E.02912
; WIPE_START
G1 X131.81 Y102.206 E-.37149
G1 X130.788 Y102.206 E-.38851
; WIPE_END
G1 E-.04 F1800
G1 X123.159 Y101.956 Z1.6 F30000
G1 X116.856 Y101.75 Z1.6
G1 Z1.2
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.57692
G1 F3000;_EXTRUDE_SET_SPEED
G1 X130.982 Y101.751 E.59586
; Slow Down End
; WIPE_START
G1 X128.982 Y101.751 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.745 Y107.2 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40779
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X134.469 Y107.924 E.05279
G1 X135.116 Y107.924 E.0334
G1 X133.947 Y106.756 E.08525
G1 X133.947 Y106.108 E.0334
G1 X135.763 Y107.924 E.13248
G1 X136.411 Y107.924 E.0334
G1 X133.947 Y105.461 E.17971
G1 X133.947 Y104.813 E.0334
G1 X137.058 Y107.924 E.22694
G1 X137.706 Y107.924 E.0334
G1 X133.947 Y104.166 E.27417
G1 X133.947 Y103.518 E.0334
G1 X138.353 Y107.924 E.3214
G1 X139 Y107.924 E.0334
G1 X132.35 Y101.273 E.4852
G1 X132.997 Y101.273 E.0334
G1 X139.648 Y107.924 E.4852
G1 X140.295 Y107.924 E.0334
G1 X133.644 Y101.273 E.48519
G1 X134.292 Y101.273 E.0334
G1 X140.943 Y107.924 E.48519
G1 X141.59 Y107.924 E.0334
G1 X134.939 Y101.273 E.48519
G1 X135.587 Y101.273 E.0334
G1 X142.238 Y107.924 E.48519
G1 X142.885 Y107.924 E.0334
G1 X136.234 Y101.273 E.48518
G1 X136.882 Y101.273 E.0334
G1 X143.532 Y107.924 E.48518
G1 X144.18 Y107.924 E.0334
G1 X137.529 Y101.273 E.48518
G1 X138.177 Y101.273 E.0334
G1 X144.827 Y107.924 E.48518
G1 X145.475 Y107.924 E.0334
G1 X138.824 Y101.273 E.48517
G1 X139.471 Y101.274 E.0334
G1 X146.122 Y107.924 E.48517
G1 X146.769 Y107.924 E.0334
G1 X140.119 Y101.274 E.48517
G1 X140.766 Y101.274 E.0334
G1 X147.417 Y107.924 E.48517
G1 X148.064 Y107.924 E.0334
G1 X141.414 Y101.274 E.48517
M73 P42 R9
G1 X142.061 Y101.274 E.0334
G1 X148.712 Y107.924 E.48516
G1 X149.359 Y107.924 E.0334
G1 X142.709 Y101.274 E.48516
G1 X143.356 Y101.274 E.0334
G1 X150.006 Y107.924 E.48516
G1 X150.654 Y107.924 E.0334
G1 X144.004 Y101.274 E.48516
G1 X144.651 Y101.274 E.0334
G1 X151.301 Y107.924 E.48515
G1 X151.949 Y107.924 E.0334
G1 X145.298 Y101.274 E.48515
G1 X145.946 Y101.274 E.0334
G1 X152.596 Y107.924 E.48515
G1 X153.028 Y107.924 E.02229
G1 X153.028 Y107.709 E.0111
G1 X146.593 Y101.274 E.46944
G1 X147.241 Y101.274 E.0334
G1 X153.028 Y107.061 E.42221
G1 X153.028 Y106.414 E.0334
G1 X147.888 Y101.274 E.37498
G1 X148.536 Y101.274 E.0334
G1 X153.028 Y105.767 E.32775
G1 X153.028 Y105.119 E.0334
G1 X149.183 Y101.274 E.28051
G1 X149.831 Y101.274 E.0334
G1 X153.028 Y104.472 E.23328
G1 X153.028 Y103.824 E.0334
G1 X150.478 Y101.274 E.18605
G1 X151.125 Y101.274 E.0334
G1 X153.028 Y103.177 E.13882
G1 X153.028 Y102.53 E.0334
G1 X151.773 Y101.274 E.09159
G3 X152.703 Y101.557 I.154 J1.166 E.05173
G1 X153.204 Y102.057 E.03648
M106 S51
; WIPE_START
G1 X152.703 Y101.557 E-.26874
G1 X152.603 Y101.47 E-.05079
G1 X152.439 Y101.373 E-.07217
G1 X152.221 Y101.298 E-.08777
G1 X152.034 Y101.274 E-.07154
G1 X151.773 Y101.274 E-.09923
G1 X151.977 Y101.478 E-.10976
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-1.207 J.156 P1  F30000
G1 X153.231 Y111.184 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.40052
M106 S255
G1 F3000
G1 X152.522 Y110.476 E.04986
G1 X151.885 Y110.476 E.0317
G1 X153.028 Y111.619 E.08045
G1 X153.028 Y112.256 E.0317
G1 X151.248 Y110.476 E.12529
G1 X150.611 Y110.476 E.0317
G1 X153.028 Y112.893 E.17012
G1 X153.028 Y113.53 E.0317
G1 X149.974 Y110.476 E.21496
G1 X149.337 Y110.476 E.0317
G1 X153.028 Y114.168 E.2598
G1 X153.028 Y114.805 E.0317
G1 X148.699 Y110.476 E.30464
G1 X148.062 Y110.476 E.0317
G1 X153.028 Y115.442 E.34947
G1 X153.028 Y116.079 E.0317
G1 X147.425 Y110.476 E.39431
G1 X146.788 Y110.476 E.0317
G1 X153.028 Y116.716 E.43915
G1 X153.028 Y117.353 E.0317
G1 X146.151 Y110.476 E.48399
G1 X145.514 Y110.476 E.03171
G1 X152.462 Y117.424 E.48897
G1 X152.335 Y117.611 E.01124
G1 X153.028 Y118.304 E.04876
G1 X153.028 Y118.627 E.0161
G1 X144.877 Y110.476 E.57366
G1 X144.24 Y110.476 E.0317
G1 X153.028 Y119.265 E.6185
G1 X153.028 Y119.902 E.0317
G1 X143.602 Y110.476 E.66334
G1 X142.965 Y110.476 E.0317
G1 X153.028 Y120.539 E.70817
G1 X153.028 Y121.176 E.0317
G1 X142.328 Y110.476 E.75301
G1 X141.691 Y110.476 E.03171
G1 X153.028 Y121.813 E.79785
G1 X153.028 Y122.45 E.0317
G1 X141.054 Y110.476 E.84268
G1 X140.417 Y110.476 E.0317
G1 X153.028 Y123.087 E.88752
G1 X153.028 Y123.725 E.03171
G1 X139.78 Y110.476 E.93236
G1 X139.143 Y110.476 E.0317
G1 X153.028 Y124.362 E.9772
M73 P42 R8
G1 X153.028 Y124.999 E.0317
G1 X138.505 Y110.476 E1.02203
G1 X137.868 Y110.476 E.0317
G1 X153.028 Y125.636 E1.06687
G1 X153.028 Y126.273 E.0317
G1 X137.231 Y110.476 E1.11171
G1 X136.594 Y110.476 E.0317
G1 X153.028 Y126.91 E1.15655
M73 P43 R8
G1 X153.028 Y127.547 E.0317
G1 X135.957 Y110.476 E1.20138
G1 X135.32 Y110.476 E.0317
G1 X153.028 Y128.184 E1.24622
G1 X153.028 Y128.822 E.0317
G1 X134.683 Y110.476 E1.29106
G1 X134.045 Y110.476 E.03171
G1 X153.028 Y129.459 E1.3359
G1 X153.028 Y130.096 E.0317
G1 X133.947 Y111.015 E1.3428
G1 X133.947 Y111.652 E.0317
G1 X153.028 Y130.733 E1.3428
G1 X153.028 Y131.37 E.0317
G1 X133.745 Y112.087 E1.35705
M106 S51
; WIPE_START
G1 X135.159 Y113.501 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I1.213 J-.092 P1  F30000
G1 X134.832 Y109.2 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.63659
; LAYER_HEIGHT: 0.2
G1 F10611.956
G1 X152.083 Y109.2 E.809
; WIPE_START
G1 X150.083 Y109.2 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I-.038 J-1.216 P1  F30000
G1 X134.347 Y109.685 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F15000
G1 X152.629 Y109.685 E.54454
G1 X152.629 Y108.715 E.02891
G1 X134.347 Y108.715 E.54454
G1 X134.347 Y109.625 E.02713
G1 X133.97 Y110.062 F30000
G1 F15000
G1 X153.006 Y110.062 E.567
G1 X153.006 Y108.338 E.05138
G1 X133.97 Y108.338 E.567
G1 X133.97 Y110.002 E.04959
; WIPE_START
G1 X133.97 Y108.338 E-.63266
G1 X134.305 Y108.338 E-.12734
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I.43 J-1.138 P1  F30000
G1 X115.082 Y101.07 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40052
; LAYER_HEIGHT: 0.4
M106 S255
G1 F3000
G1 X115.99 Y101.977 E.06384
G1 X116.127 Y102.228 E.01426
G1 X115.604 Y102.228 E.02604
G1 X114.648 Y101.272 E.06728
G1 X114.011 Y101.272 E.03171
G1 X114.967 Y102.228 E.06728
G1 X114.528 Y102.228 E.02181
G1 X114.528 Y102.427 E.00989
G1 X113.373 Y101.272 E.08127
G1 X112.736 Y101.272 E.03171
G1 X114.528 Y103.064 E.12611
G1 X114.528 Y103.701 E.0317
G1 X112.099 Y101.272 E.17095
G1 X111.462 Y101.272 E.03171
G1 X114.528 Y104.338 E.21579
G1 X114.528 Y104.976 E.0317
G1 X110.825 Y101.272 E.26063
G1 X110.188 Y101.272 E.03171
G1 X114.528 Y105.613 E.30547
G1 X114.528 Y106.25 E.03171
G1 X109.55 Y101.272 E.35031
G1 X108.913 Y101.272 E.03171
G1 X114.528 Y106.887 E.39515
G1 X114.528 Y107.524 E.0317
G1 X108.276 Y101.272 E.43999
G1 X107.639 Y101.272 E.03171
G1 X114.528 Y108.161 E.48483
G1 X114.528 Y108.798 E.03171
G1 X106.799 Y101.069 E.54392
M106 S51
; WIPE_START
G1 X108.213 Y102.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.369 Y107.188 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X110.81 Y107.628 E.031
G1 X111.447 Y107.628 E.0317
G1 X110.572 Y106.753 E.06159
G1 X110.572 Y106.116 E.0317
G1 X112.286 Y107.831 E.12067
M106 S51
; WIPE_START
G1 X110.872 Y106.417 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.631 Y111.458 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X106.945 Y110.772 E.04829
G1 X106.307 Y110.772 E.0317
G1 X107.428 Y111.892 E.07887
G1 X107.428 Y112.53 E.03171
G1 X105.468 Y110.569 E.13796
M106 S51
; WIPE_START
G1 X106.882 Y111.983 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.769 Y112.968 Z1.6 F30000
G1 Z1.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X113.046 Y123.244 E.7232
G3 X113.066 Y122.628 I2.285 J-.232 E.03079
G1 X102.972 Y112.533 E.7104
G1 X102.972 Y111.896 E.0317
G1 X113.227 Y122.151 E.72172
G1 X113.454 Y121.741 E.02332
G1 X102.972 Y111.259 E.73772
G1 X102.972 Y110.622 E.0317
G1 X113.798 Y121.448 E.76192
G3 X114.197 Y121.21 I.722 J.754 E.02331
G1 X102.972 Y109.984 E.78997
M73 P44 R8
G1 X102.972 Y109.347 E.0317
G1 X114.679 Y121.055 E.82392
G1 X115.13 Y121.03 E.02246
G1 X115.32 Y121.059 E.00956
G1 X102.972 Y108.71 E.869
G1 X102.972 Y108.073 E.0317
G1 X105.028 Y110.13 E.14473
G1 X105.028 Y109.492 E.0317
G1 X102.972 Y107.436 E.14473
G1 X102.972 Y106.799 E.0317
G1 X105.028 Y108.855 E.14473
G1 X105.028 Y108.218 E.0317
G1 X102.972 Y106.162 E.14473
G1 X102.972 Y105.524 E.03171
G1 X105.076 Y107.628 E.14805
G1 X105.713 Y107.628 E.0317
G1 X102.972 Y104.887 E.19289
G1 X102.972 Y104.25 E.03171
G1 X106.35 Y107.628 E.23773
G1 X106.987 Y107.628 E.0317
G1 X102.972 Y103.613 E.28257
G1 X102.972 Y102.976 E.0317
G1 X107.428 Y107.433 E.31363
G1 X107.428 Y106.795 E.0317
G1 X102.972 Y102.339 E.31363
G3 X103.097 Y101.827 I1.09 J-.004 E.02648
G1 X107.428 Y106.158 E.30481
G1 X107.428 Y105.521 E.0317
G1 X103.389 Y101.482 E.28425
G3 X103.837 Y101.293 I.589 J.769 E.02445
G1 X107.773 Y105.228 E.27697
G1 X108.41 Y105.228 E.0317
G1 X104.453 Y101.272 E.27844
G1 X105.09 Y101.272 E.03171
G1 X109.047 Y105.228 E.27844
G1 X109.684 Y105.228 E.0317
G1 X105.727 Y101.272 E.27843
G1 X106.365 Y101.272 E.03171
G1 X114.528 Y109.436 E.57451
G1 X114.528 Y110.073 E.0317
G1 X112.972 Y108.516 E.10954
G1 X112.972 Y109.153 E.03171
G1 X114.528 Y110.71 E.10954
G1 X114.528 Y111.347 E.0317
G1 X112.972 Y109.79 E.10954
G1 X112.972 Y110.427 E.0317
G1 X114.528 Y111.984 E.10954
G1 X114.528 Y112.621 E.0317
G1 X112.679 Y110.772 E.13015
G1 X112.042 Y110.772 E.0317
G1 X114.528 Y113.258 E.17499
G1 X114.528 Y113.895 E.0317
G1 X111.405 Y110.772 E.21983
G1 X110.767 Y110.772 E.03171
G1 X114.528 Y114.533 E.26467
G1 X114.528 Y115.17 E.0317
G1 X110.572 Y111.213 E.27844
G1 X110.572 Y111.85 E.0317
G1 X131.55 Y132.828 E1.47631
G1 X130.913 Y132.828 E.0317
G1 X110.572 Y112.487 E1.43147
G1 X110.572 Y113.124 E.0317
G1 X130.275 Y132.828 E1.38663
G1 X129.638 Y132.828 E.03171
G1 X125.987 Y129.177 E.25696
G1 X126.446 Y129.177 E.02282
G1 X125.758 Y128.49 E.04838
G1 X125.529 Y128.719 E.01614
G1 X109.982 Y113.172 E1.09411
G1 X109.345 Y113.172 E.0317
G1 X129.001 Y132.828 E1.38331
G1 X128.364 Y132.828 E.0317
G1 X108.707 Y113.172 E1.38331
G1 X108.07 Y113.172 E.0317
G1 X127.727 Y132.828 E1.38331
G1 X127.09 Y132.828 E.0317
G1 X116.947 Y122.685 E.71379
G1 X116.951 Y122.701 E.00081
G3 X116.945 Y123.32 I-2.253 J.286 E.03091
G1 X126.453 Y132.828 E.66911
G1 X125.816 Y132.828 E.0317
G1 X116.79 Y123.803 E.63514
G3 X116.558 Y124.208 I-1.182 J-.41 E.02336
G1 X125.178 Y132.828 E.60667
G1 X124.541 Y132.828 E.0317
G1 X116.245 Y124.532 E.58384
G3 X115.85 Y124.774 I-1.806 J-2.498 E.02307
M73 P45 R8
G1 X123.904 Y132.828 E.56678
G1 X123.267 Y132.828 E.0317
G1 X115.371 Y124.932 E.5557
G3 X114.88 Y124.966 I-.4 J-2.221 E.02453
G1 X114.758 Y124.956 E.00609
G1 X122.63 Y132.828 E.55399
G1 X121.993 Y132.828 E.0317
G1 X118.341 Y129.177 E.25696
G1 X118.809 Y129.177 E.02326
G1 X118.102 Y128.47 E.04976
G1 X117.868 Y128.704 E.01645
G1 X106.766 Y117.602 E.78127
G1 X107.344 Y117.602 E.02873
G1 X106.643 Y116.901 E.04933
G1 X106.354 Y117.19 E.02032
G1 X102.972 Y113.807 E.23804
G1 X102.972 Y114.444 E.0317
G1 X121.356 Y132.828 E1.29375
G1 X120.719 Y132.828 E.0317
G1 X102.972 Y115.081 E1.24891
G1 X102.972 Y115.719 E.03171
G1 X120.081 Y132.828 E1.20407
G1 X119.444 Y132.828 E.0317
G1 X102.972 Y116.356 E1.15924
G1 X102.972 Y116.73 E.01862
G1 X103.844 Y117.602 E.06137
G1 X103.581 Y117.602 E.01308
G1 X118.807 Y132.828 E1.07154
G1 X118.17 Y132.828 E.0317
G1 X102.972 Y117.63 E1.06956
G1 X102.972 Y118.267 E.0317
G1 X117.533 Y132.828 E1.02473
G1 X116.896 Y132.828 E.0317
G1 X102.972 Y118.904 E.97989
G1 X102.972 Y119.541 E.0317
G1 X116.259 Y132.828 E.93505
G1 X115.621 Y132.828 E.0317
G1 X102.972 Y120.179 E.89021
G1 X102.972 Y120.816 E.0317
G1 X114.984 Y132.828 E.84538
G1 X114.528 Y132.828 E.02269
G1 X114.528 Y133.009 E.00901
G1 X102.972 Y121.453 E.81328
G1 X102.972 Y122.09 E.0317
G1 X114.528 Y133.647 E.81328
G1 X114.528 Y134.284 E.0317
G1 X102.972 Y122.727 E.81328
G1 X102.972 Y123.364 E.03171
G1 X114.528 Y134.921 E.81328
G1 X114.528 Y135.558 E.03171
G1 X102.972 Y124.001 E.81328
G1 X102.972 Y124.638 E.0317
G1 X114.528 Y136.195 E.81328
G1 X114.528 Y136.832 E.0317
G1 X102.972 Y125.276 E.81328
G1 X102.972 Y125.913 E.03171
G1 X114.528 Y137.469 E.81328
G1 X114.528 Y138.106 E.0317
G1 X102.972 Y126.55 E.81328
G1 X102.972 Y127.187 E.0317
G1 X114.528 Y138.744 E.81328
M73 P46 R8
G1 X114.528 Y139.381 E.0317
G1 X102.769 Y127.622 E.82753
M106 S51
; WIPE_START
G1 X104.183 Y129.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.05 Y136.584 Z1.6 F30000
G1 X102.769 Y138.453 Z1.6
G1 Z1.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X105.028 Y140.712 E.15898
G1 X105.028 Y140.075 E.0317
G1 X102.972 Y138.018 E.14473
G1 X102.972 Y137.381 E.0317
G1 X105.028 Y139.438 E.14473
G1 X105.028 Y138.801 E.0317
G1 X102.972 Y136.744 E.14473
G1 X102.972 Y136.107 E.0317
G1 X105.093 Y138.228 E.1493
G1 X105.73 Y138.228 E.03171
G1 X102.972 Y135.47 E.19414
G1 X102.972 Y134.833 E.0317
G1 X106.367 Y138.228 E.23897
G1 X107.005 Y138.228 E.0317
G1 X102.972 Y134.195 E.28381
G1 X102.972 Y133.558 E.0317
G1 X107.642 Y138.228 E.32865
G1 X108.279 Y138.228 E.0317
G1 X102.972 Y132.921 E.37348
G1 X102.972 Y132.284 E.03171
G1 X108.916 Y138.228 E.41832
G1 X109.553 Y138.228 E.0317
G1 X102.972 Y131.647 E.46316
G1 X102.972 Y131.01 E.0317
G1 X110.19 Y138.228 E.508
G1 X110.827 Y138.228 E.0317
G1 X102.972 Y130.373 E.55283
G1 X102.972 Y129.735 E.0317
G1 X111.465 Y138.228 E.59767
G1 X112.102 Y138.228 E.0317
G1 X102.972 Y129.098 E.64251
G1 X102.972 Y128.461 E.0317
G1 X114.528 Y140.018 E.81328
G1 X114.528 Y140.655 E.0317
G1 X112.972 Y139.098 E.10954
G1 X112.972 Y139.735 E.0317
G1 X114.528 Y141.292 E.10954
G1 X114.528 Y141.929 E.0317
G1 X112.972 Y140.373 E.10954
G1 X112.972 Y141.01 E.0317
G1 X114.528 Y142.566 E.10954
G1 X114.528 Y143.203 E.0317
G1 X112.696 Y141.372 E.12891
G1 X112.059 Y141.372 E.0317
G1 X114.528 Y143.841 E.17375
G1 X114.528 Y144.478 E.0317
G1 X111.422 Y141.372 E.21859
G1 X110.785 Y141.372 E.0317
G1 X114.528 Y145.115 E.26342
G1 X114.528 Y145.752 E.03171
G1 X110.148 Y141.372 E.30826
G1 X109.511 Y141.372 E.0317
G1 X118.867 Y150.728 E.65846
G1 X118.23 Y150.728 E.03171
G1 X108.874 Y141.372 E.65846
G1 X108.237 Y141.372 E.0317
G1 X117.593 Y150.728 E.65846
G1 X116.956 Y150.728 E.0317
G1 X107.599 Y141.372 E.65846
G1 X106.962 Y141.372 E.03171
G1 X116.319 Y150.728 E.65846
G1 X115.682 Y150.728 E.0317
G1 X106.325 Y141.372 E.65846
G1 X105.688 Y141.372 E.0317
G1 X115.045 Y150.728 E.65846
G1 X114.408 Y150.728 E.0317
G1 X102.972 Y139.292 E.80478
G1 X102.972 Y139.93 E.0317
G1 X113.77 Y150.728 E.75995
G1 X113.133 Y150.728 E.0317
G1 X102.972 Y140.567 E.71511
G1 X102.972 Y141.204 E.03171
G1 X112.496 Y150.728 E.67027
G1 X111.859 Y150.728 E.0317
G1 X102.972 Y141.841 E.62543
G1 X102.972 Y142.478 E.03171
G1 X111.222 Y150.728 E.5806
G1 X110.585 Y150.728 E.03171
G1 X102.972 Y143.115 E.53576
G1 X102.972 Y143.752 E.0317
G1 X109.948 Y150.728 E.49092
G1 X109.31 Y150.728 E.0317
G1 X102.972 Y144.39 E.44608
G1 X102.972 Y145.027 E.0317
G1 X108.673 Y150.728 E.40125
G1 X108.036 Y150.728 E.0317
G1 X102.972 Y145.664 E.35641
G1 X102.972 Y146.301 E.0317
G1 X107.399 Y150.728 E.31157
M73 P47 R8
G1 X106.762 Y150.728 E.03171
G1 X102.972 Y146.938 E.26673
G1 X102.972 Y147.575 E.0317
G1 X106.125 Y150.728 E.2219
G1 X105.488 Y150.728 E.0317
G1 X102.972 Y148.212 E.17706
G1 X102.972 Y148.849 E.0317
G1 X104.851 Y150.728 E.13222
G1 X104.213 Y150.728 E.0317
G1 X102.769 Y149.284 E.10164
M106 S51
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X104.183 Y150.698 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 7/22
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
G17
G3 Z1.6 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.577 Y122.271
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.592 Y122.23 E.00138
G3 X127.766 Y121.415 I1.404 J.768 E.04766
G1 X127.918 Y121.4 E.0049
G3 X126.466 Y122.527 I.078 J1.598 E.26038
G1 X126.554 Y122.326 E.00705
M204 S250
G1 X126.937 Y122.423 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.936 Y122.416 E.00022
G3 X127.821 Y121.803 I1.058 J.583 E.03323
G1 X127.935 Y121.792 E.00341
G3 X126.84 Y122.642 I.059 J1.207 E.18215
G1 X126.913 Y122.478 E.00535
; WIPE_START
M204 S10000
G1 X126.936 Y122.416 E-.02526
G1 X127.054 Y122.245 E-.07865
G1 X127.179 Y122.11 E-.07002
G1 X127.393 Y121.953 E-.10108
G1 X127.582 Y121.865 E-.07912
G1 X127.821 Y121.803 E-.09386
G1 X127.935 Y121.792 E-.04354
G1 X128.18 Y121.803 E-.09315
G1 X128.442 Y121.874 E-.10303
G1 X128.613 Y121.958 E-.07229
; WIPE_END
G1 E-.04 F1800
G1 X120.992 Y122.378 Z1.8 F30000
G1 X116.549 Y122.623 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.593 Y122.88 E.0084
G3 X114.766 Y121.415 I-1.598 J.119 E.23917
G1 X114.918 Y121.4 E.0049
G3 X116.527 Y122.529 I.078 J1.6 E.06807
G1 X116.536 Y122.564 E.00117
M204 S250
G1 X116.166 Y122.695 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.201 Y122.91 E.00648
G3 X114.821 Y121.803 I-1.206 J.09 E.16731
G1 X114.935 Y121.792 E.00341
G3 X116.149 Y122.638 I.059 J1.208 E.04741
; WIPE_START
M204 S10000
G1 X116.201 Y122.91 E-.10525
G1 X116.207 Y123.094 E-.06993
G1 X116.156 Y123.358 E-.10232
G1 X116.049 Y123.604 E-.10175
G1 X115.904 Y123.804 E-.09379
G1 X115.753 Y123.947 E-.07913
G1 X115.527 Y124.09 E-.10176
G1 X115.273 Y124.179 E-.10232
G1 X115.263 Y124.181 E-.00374
; WIPE_END
G1 E-.04 F1800
G1 X115.272 Y131.813 Z1.8 F30000
G1 X115.29 Y146.402 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.01261
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y146.402 E.4246
G1 X115.35 Y146.402 E.57084
M204 S250
G1 X115.29 Y146.01 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y146.01 E.36995
G1 X115.35 Y146.01 E.5171
; WIPE_START
M204 S10000
G1 X115.34 Y144.01 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.7 Y140.247 Z1.8 F30000
G1 X105.79 Y138.598 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.381 Y131.422 Z1.8 F30000
G1 X110.202 Y107.998 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.002 Y110.934 Z1.8 F30000
G1 X132.71 Y115.802 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.57277
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y115.802 E.4246
G1 X132.77 Y115.802 E.01068
M204 S250
G1 X132.71 Y115.41 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y115.35 E.36816
; WIPE_START
M204 S10000
G1 X130.71 Y115.357 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.215 Y119.35 Z1.8 F30000
G1 X142.55 Y122.625 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.593 Y122.88 E.00834
G3 X140.766 Y121.415 I-1.597 J.119 E.23917
G1 X140.918 Y121.4 E.0049
G3 X142.527 Y122.529 I.078 J1.6 E.06807
G1 X142.536 Y122.567 E.00124
M204 S250
G1 X142.167 Y122.697 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.201 Y122.91 E.00641
G3 X140.821 Y121.803 I-1.206 J.09 E.16731
G1 X140.935 Y121.792 E.00341
G3 X142.15 Y122.64 I.059 J1.208 E.04747
; WIPE_START
M204 S10000
G1 X142.201 Y122.91 E-.10445
G1 X142.207 Y123.094 E-.06993
G1 X142.156 Y123.358 E-.10232
G1 X142.049 Y123.604 E-.10175
G1 X141.904 Y123.804 E-.09379
G1 X141.753 Y123.947 E-.07913
G1 X141.527 Y124.09 E-.10176
G1 X141.273 Y124.179 E-.10232
G1 X141.261 Y124.181 E-.00454
; WIPE_END
G1 E-.04 F1800
G1 X144.411 Y131.133 Z1.8 F30000
G1 X153.169 Y150.461 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X151.989 Y151.098 I-1.176 J-.768 E.04496
G1 X104.011 Y151.098 E1.54279
G3 X102.602 Y149.689 I-.009 J-1.4 E.07129
G1 X102.602 Y102.311 E1.52352
G3 X104.011 Y100.902 I1.405 J-.004 E.07122
G1 X152.072 Y100.905 E1.54546
G3 X153.398 Y102.311 I-.081 J1.405 E.0685
G1 X153.398 Y149.689 E1.52352
G3 X153.201 Y150.411 I-1.405 J.004 E.02434
M204 S250
G1 X153.5 Y150.672 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.507 J-.979 E.05314
G1 X104.004 Y151.49 E1.42952
G3 X102.21 Y149.696 I-.002 J-1.792 E.08396
G1 X102.21 Y102.304 E1.41165
G3 X104.004 Y100.51 I1.797 J.003 E.0839
G1 X152.086 Y100.513 E1.43221
G3 X153.79 Y102.304 I-.097 J1.799 E.08114
G1 X153.79 Y149.696 E1.41165
G3 X153.532 Y150.622 I-1.797 J-.003 E.02897
; WIPE_START
M204 S10000
G1 X153.289 Y150.942 E-.15271
G1 X152.987 Y151.193 E-.14923
G1 X152.714 Y151.34 E-.11789
G1 X152.389 Y151.447 E-.13
G1 X151.996 Y151.49 E-.15018
G1 X151.838 Y151.49 E-.05999
; WIPE_END
G1 E-.04 F1800
G1 X152.344 Y150.879 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42109
G1 F15000
G1 X117.601 Y116.135 E1.4678
G1 X117.066 Y116.135 E.01598
G1 X151.695 Y150.765 E1.46297
G1 X151.161 Y150.765 E.01598
G1 X116.361 Y115.966 E1.47014
; WIPE_START
G1 X117.775 Y117.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.088 Y110.697 Z1.8 F30000
G1 X112.509 Y107.834 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X110.535 Y105.861 E.08337
G1 X110.535 Y106.396 E.01598
G1 X111.804 Y107.665 E.05361
G1 X111.269 Y107.665 E.01598
G1 X110.535 Y106.931 E.03102
G1 X110.535 Y107.465 E.01598
G1 X110.904 Y107.834 E.01559
; WIPE_START
G1 X110.535 Y107.465 E-.19831
G1 X110.535 Y106.931 E-.20323
G1 X111.202 Y107.598 E-.35846
; WIPE_END
G1 E-.04 F1800
G1 X110.109 Y105.434 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X105.91 Y101.235 E.1774
G1 X105.375 Y101.235 E.01598
G1 X109.404 Y105.265 E.17023
G1 X108.869 Y105.265 E.01598
M73 P48 R8
G1 X104.84 Y101.235 E.17023
G1 X104.305 Y101.235 E.01598
G1 X108.335 Y105.265 E.17023
G1 X107.8 Y105.265 E.01598
G1 X103.795 Y101.26 E.16917
G2 X103.417 Y101.412 I.267 J1.217 E.01223
G1 X107.465 Y105.465 E.17111
G1 X107.465 Y105.999 E.01598
G1 X103.143 Y101.678 E.18257
G2 X102.971 Y102.04 I1.123 J.755 E.01204
G1 X107.465 Y106.534 E.18985
G1 X107.465 Y107.069 E.01598
G1 X102.935 Y102.539 E.19136
G1 X102.935 Y103.074 E.01598
G1 X107.465 Y107.604 E.19136
G1 X107.465 Y107.665 E.00182
G1 X106.991 Y107.665 E.01416
G1 X102.935 Y103.609 E.17134
G1 X102.935 Y104.144 E.01598
G1 X106.456 Y107.665 E.14874
G1 X105.921 Y107.665 E.01598
G1 X102.935 Y104.679 E.12615
G1 X102.935 Y105.214 E.01598
G1 X105.386 Y107.665 E.10356
G1 X105.065 Y107.665 E.00961
G1 X105.065 Y107.878 E.00637
G1 X102.935 Y105.748 E.08997
G1 X102.935 Y106.283 E.01598
G1 X105.065 Y108.413 E.08997
G1 X105.065 Y108.948 E.01598
G1 X102.935 Y106.818 E.08997
G1 X102.935 Y107.353 E.01598
G1 X105.065 Y109.482 E.08997
G1 X105.065 Y110.017 E.01598
G1 X102.935 Y107.888 E.08997
G1 X102.935 Y108.422 E.01598
G1 X127.378 Y132.865 E1.0326
G1 X127.912 Y132.865 E.01598
G1 X108.183 Y113.135 E.8335
G1 X108.718 Y113.135 E.01598
G1 X128.447 Y132.865 E.8335
G1 X128.982 Y132.865 E.01598
G1 X109.252 Y113.135 E.8335
G1 X109.787 Y113.135 E.01598
G1 X129.517 Y132.865 E.8335
G1 X130.052 Y132.865 E.01598
G1 X110.322 Y113.135 E.8335
G1 X110.535 Y113.135 E.00637
G1 X110.535 Y112.814 E.00961
G1 X130.586 Y132.865 E.84709
G1 X131.121 Y132.865 E.01598
G1 X110.366 Y112.109 E.87685
; WIPE_START
G1 X111.78 Y113.523 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.634 Y112.587 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X105.783 Y110.735 E.07822
G1 X106.318 Y110.735 E.01598
G1 X107.465 Y111.882 E.04846
G1 X107.465 Y111.348 E.01598
G1 X106.852 Y110.735 E.02587
G1 X107.387 Y110.735 E.01598
G1 X107.634 Y110.982 E.01044
; WIPE_START
G1 X107.387 Y110.735 E-.13284
G1 X106.852 Y110.735 E-.20323
G1 X107.465 Y111.348 E-.32907
G1 X107.465 Y111.597 E-.09486
; WIPE_END
G1 E-.04 F1800
G1 X114.642 Y109 Z1.8 F30000
G1 X132.78 Y102.434 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X131.582 Y101.237 E.05059
G1 X131.047 Y101.237 E.01598
G1 X132.075 Y102.265 E.04342
G1 X131.54 Y102.265 E.01598
G1 X130.513 Y101.237 E.04343
G1 X129.978 Y101.237 E.01598
G1 X131.006 Y102.265 E.04343
G1 X130.471 Y102.265 E.01598
G1 X129.443 Y101.237 E.04343
G1 X128.908 Y101.237 E.01598
G1 X129.936 Y102.265 E.04343
G1 X129.401 Y102.265 E.01598
G1 X128.373 Y101.237 E.04343
G1 X127.838 Y101.237 E.01598
G1 X128.866 Y102.265 E.04343
G1 X128.332 Y102.265 E.01598
G1 X127.303 Y101.237 E.04343
G1 X126.769 Y101.237 E.01598
G1 X127.797 Y102.265 E.04344
G1 X127.262 Y102.265 E.01598
G1 X126.234 Y101.237 E.04344
G1 X125.699 Y101.237 E.01598
G1 X126.727 Y102.265 E.04344
G1 X126.192 Y102.265 E.01598
G1 X125.164 Y101.237 E.04344
G1 X124.629 Y101.236 E.01598
G1 X125.657 Y102.265 E.04344
G1 X125.123 Y102.265 E.01598
G1 X124.094 Y101.236 E.04344
G1 X123.559 Y101.236 E.01598
G1 X124.588 Y102.265 E.04344
G1 X124.053 Y102.265 E.01598
G1 X123.025 Y101.236 E.04344
G1 X122.49 Y101.236 E.01598
G1 X123.518 Y102.265 E.04345
G1 X122.983 Y102.265 E.01598
G1 X121.955 Y101.236 E.04345
G1 X121.42 Y101.236 E.01598
G1 X122.449 Y102.265 E.04345
G1 X121.914 Y102.265 E.01598
G1 X120.885 Y101.236 E.04345
G1 X120.35 Y101.236 E.01598
G1 X121.379 Y102.265 E.04345
G1 X120.844 Y102.265 E.01598
G1 X119.816 Y101.236 E.04345
G1 X119.281 Y101.236 E.01598
G1 X120.309 Y102.265 E.04345
G1 X119.775 Y102.265 E.01598
G1 X118.746 Y101.236 E.04346
G1 X118.211 Y101.236 E.01598
G1 X119.24 Y102.265 E.04346
G1 X118.705 Y102.265 E.01598
G1 X117.676 Y101.236 E.04346
G1 X117.141 Y101.236 E.01598
G1 X118.17 Y102.265 E.04346
G1 X117.635 Y102.265 E.01598
G1 X116.606 Y101.236 E.04346
G1 X116.072 Y101.236 E.01598
G1 X117.1 Y102.265 E.04346
G1 X116.566 Y102.265 E.01598
G1 X115.537 Y101.236 E.04346
G1 X115.002 Y101.236 E.01598
G1 X116.031 Y102.265 E.04347
G1 X115.496 Y102.265 E.01598
G1 X114.467 Y101.236 E.04347
G1 X113.932 Y101.236 E.01598
G1 X114.961 Y102.265 E.04347
G1 X114.565 Y102.265 E.01184
G1 X114.565 Y102.403 E.00413
G1 X113.397 Y101.236 E.04932
G1 X112.863 Y101.236 E.01598
G1 X114.565 Y102.938 E.07191
G1 X114.565 Y103.473 E.01598
G1 X112.328 Y101.236 E.09451
G1 X111.793 Y101.236 E.01598
G1 X114.565 Y104.008 E.1171
G1 X114.565 Y104.542 E.01598
G1 X111.258 Y101.236 E.1397
G1 X110.723 Y101.236 E.01598
G1 X114.565 Y105.077 E.16229
G1 X114.565 Y105.612 E.01598
G1 X110.188 Y101.236 E.18489
G1 X109.653 Y101.236 E.01598
G1 X114.565 Y106.147 E.20748
G1 X114.565 Y106.682 E.01598
G1 X109.119 Y101.236 E.23008
G1 X108.584 Y101.235 E.01598
G1 X114.565 Y107.216 E.25267
G1 X114.565 Y107.751 E.01598
G1 X108.049 Y101.235 E.27527
G1 X107.514 Y101.235 E.01598
G1 X114.565 Y108.286 E.29787
G1 X114.565 Y108.821 E.01598
G1 X106.979 Y101.235 E.32046
G1 X106.444 Y101.235 E.01598
G1 X114.565 Y109.356 E.34306
G1 X114.565 Y109.891 E.01598
G1 X112.935 Y108.261 E.06884
G1 X112.935 Y108.796 E.01598
G1 X114.565 Y110.425 E.06884
G1 X114.565 Y110.96 E.01598
G1 X112.935 Y109.331 E.06884
G1 X112.935 Y109.865 E.01598
G1 X114.565 Y111.495 E.06884
G1 X114.565 Y112.03 E.01598
G1 X112.935 Y110.4 E.06884
G1 X112.935 Y110.735 E.01001
G1 X112.735 Y110.735 E.00597
G1 X114.565 Y112.565 E.07728
G1 X114.565 Y113.099 E.01598
G1 X112.201 Y110.735 E.09988
G1 X111.666 Y110.735 E.01598
G1 X114.565 Y113.634 E.12247
G1 X114.565 Y114.169 E.01598
G1 X111.131 Y110.735 E.14507
G1 X110.596 Y110.735 E.01598
G1 X114.565 Y114.704 E.16766
G1 X114.565 Y115.239 E.01598
G1 X110.535 Y111.209 E.17023
G1 X110.535 Y111.744 E.01598
G1 X114.565 Y115.773 E.17023
G1 X114.565 Y116.135 E.01081
G1 X114.927 Y116.135 E.01081
G1 X131.656 Y132.865 E.70676
G1 X132.191 Y132.865 E.01598
G1 X115.461 Y116.135 E.70676
G1 X115.996 Y116.135 E.01598
G1 X132.895 Y133.034 E.71393
; WIPE_START
G1 X131.481 Y131.62 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.012 Y133.034 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X116.933 Y122.955 E.42581
G1 X116.882 Y123.439 E.01452
G1 X126.308 Y132.865 E.39822
G1 X125.773 Y132.865 E.01598
G1 X116.744 Y123.835 E.38146
G1 X116.593 Y124.103 E.00918
G1 X116.539 Y124.166 E.00246
G1 X125.238 Y132.865 E.36751
G1 X124.703 Y132.865 E.01598
G1 X116.284 Y124.445 E.35569
G3 X115.971 Y124.667 I-.707 J-.666 E.01154
G1 X124.169 Y132.865 E.34632
G1 X123.634 Y132.865 E.01598
G1 X115.604 Y124.835 E.33923
G1 X115.287 Y124.916 E.00978
G1 X115.155 Y124.921 E.00393
G1 X123.099 Y132.865 E.33559
G1 X122.564 Y132.865 E.01598
G1 X114.323 Y124.623 E.34817
; WIPE_START
G1 X115.737 Y126.038 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.232 Y121.254 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X102.935 Y108.957 E.51948
G1 X102.935 Y109.492 E.01598
G1 X114.565 Y121.122 E.49132
G2 X114.168 Y121.259 I.163 J1.117 E.01264
G1 X102.935 Y110.027 E.47453
G1 X102.935 Y110.562 E.01598
G1 X113.837 Y121.464 E.46057
G2 X113.56 Y121.722 I.424 J.732 E.0114
G1 X102.935 Y111.096 E.44888
G1 X102.935 Y111.631 E.01598
G1 X113.334 Y122.03 E.4393
G2 X113.165 Y122.396 I.882 J.627 E.01212
G1 X102.935 Y112.166 E.43219
G1 X102.935 Y112.701 E.01598
G1 X113.074 Y122.84 E.42834
G2 X113.109 Y123.41 I1.293 J.207 E.01719
G1 X102.935 Y113.236 E.42981
G1 X102.935 Y113.771 E.01598
G1 X122.029 Y132.865 E.80666
G1 X121.495 Y132.865 E.01598
G1 X102.935 Y114.305 E.78407
G1 X102.935 Y114.84 E.01598
G1 X120.96 Y132.865 E.76147
G1 X120.425 Y132.865 E.01598
G1 X102.935 Y115.375 E.73888
G1 X102.935 Y115.91 E.01598
G1 X119.89 Y132.865 E.71629
G1 X119.355 Y132.865 E.01598
G1 X102.935 Y116.445 E.69369
G1 X102.935 Y116.979 E.01598
G1 X118.821 Y132.865 E.6711
G1 X118.286 Y132.865 E.01598
G1 X102.935 Y117.514 E.6485
G1 X102.935 Y118.049 E.01598
G1 X117.751 Y132.865 E.62591
G1 X117.216 Y132.865 E.01598
G1 X102.935 Y118.584 E.60332
G1 X102.935 Y119.119 E.01598
G1 X116.681 Y132.865 E.58072
G1 X116.146 Y132.865 E.01598
G1 X102.935 Y119.654 E.55813
G1 X102.935 Y120.188 E.01598
G1 X115.612 Y132.865 E.53553
G1 X115.077 Y132.865 E.01598
G1 X102.935 Y120.723 E.51294
G1 X102.935 Y121.258 E.01598
G1 X114.565 Y132.887 E.49131
M73 P49 R8
G1 X114.565 Y133.422 E.01598
G1 X102.935 Y121.793 E.49131
G1 X102.935 Y122.328 E.01598
G1 X114.565 Y133.957 E.49131
G1 X114.565 Y134.492 E.01598
G1 X102.935 Y122.862 E.49131
G1 X102.935 Y123.397 E.01598
G1 X114.565 Y135.027 E.49131
G1 X114.565 Y135.562 E.01598
G1 X102.935 Y123.932 E.49131
G1 X102.935 Y124.467 E.01598
G1 X114.565 Y136.096 E.49131
G1 X114.565 Y136.631 E.01598
G1 X102.935 Y125.002 E.49131
G1 X102.935 Y125.536 E.01598
G1 X114.565 Y137.166 E.49131
G1 X114.565 Y137.701 E.01598
G1 X102.935 Y126.071 E.49131
G1 X102.935 Y126.606 E.01598
G1 X114.565 Y138.236 E.49131
G1 X114.565 Y138.77 E.01598
G1 X102.935 Y127.141 E.49131
G1 X102.935 Y127.676 E.01598
G1 X114.565 Y139.305 E.49131
G1 X114.565 Y139.84 E.01598
G1 X102.935 Y128.211 E.49131
G1 X102.935 Y128.745 E.01598
G1 X112.455 Y138.265 E.40216
M73 P49 R7
G1 X112.935 Y138.265 E.01436
G1 X112.935 Y138.745 E.01436
G1 X114.565 Y140.375 E.06884
G1 X114.565 Y140.91 E.01598
G1 X112.935 Y139.28 E.06884
G1 X112.935 Y139.815 E.01598
G1 X114.565 Y141.445 E.06884
G1 X114.565 Y141.979 E.01598
G1 X112.935 Y140.35 E.06884
G1 X112.935 Y140.885 E.01598
G1 X114.565 Y142.514 E.06884
G1 X114.565 Y143.049 E.01598
G1 X112.851 Y141.335 E.0724
G1 X112.316 Y141.335 E.01598
G1 X114.565 Y143.584 E.09499
G1 X114.565 Y144.119 E.01598
G1 X111.781 Y141.335 E.11759
G1 X111.247 Y141.335 E.01598
G1 X114.565 Y144.653 E.14018
G1 X114.565 Y145.188 E.01598
G1 X110.712 Y141.335 E.16277
G1 X110.177 Y141.335 E.01598
G1 X114.565 Y145.723 E.18537
G1 X114.565 Y146.258 E.01598
G1 X109.642 Y141.335 E.20796
G1 X109.107 Y141.335 E.01598
G1 X118.537 Y150.765 E.39836
G1 X119.072 Y150.765 E.01598
G1 X115.042 Y146.735 E.17023
G1 X115.577 Y146.735 E.01598
G1 X119.607 Y150.765 E.17023
G1 X120.141 Y150.765 E.01598
G1 X116.112 Y146.735 E.17023
G1 X116.647 Y146.735 E.01598
G1 X120.676 Y150.765 E.17023
G1 X121.211 Y150.765 E.01598
G1 X117.181 Y146.735 E.17023
G1 X117.716 Y146.735 E.01598
G1 X121.746 Y150.765 E.17023
G1 X122.281 Y150.765 E.01598
G1 X118.251 Y146.735 E.17023
G1 X118.786 Y146.735 E.01598
G1 X122.815 Y150.765 E.17023
G1 X123.35 Y150.765 E.01598
G1 X119.321 Y146.735 E.17023
G1 X119.855 Y146.735 E.01598
G1 X123.885 Y150.765 E.17023
G1 X124.42 Y150.765 E.01598
G1 X120.39 Y146.735 E.17023
G1 X120.925 Y146.735 E.01598
G1 X124.955 Y150.765 E.17023
G1 X125.489 Y150.765 E.01598
G1 X121.46 Y146.735 E.17023
G1 X121.995 Y146.735 E.01598
G1 X126.024 Y150.765 E.17023
G1 X126.559 Y150.765 E.01598
G1 X122.53 Y146.735 E.17023
G1 X123.064 Y146.735 E.01598
G1 X127.094 Y150.765 E.17023
G1 X127.629 Y150.765 E.01598
G1 X123.599 Y146.735 E.17023
G1 X124.134 Y146.735 E.01598
G1 X128.164 Y150.765 E.17023
G1 X128.698 Y150.765 E.01598
G1 X124.669 Y146.735 E.17023
G1 X125.204 Y146.735 E.01598
G1 X129.233 Y150.765 E.17023
G1 X129.768 Y150.765 E.01598
G1 X125.738 Y146.735 E.17023
G1 X126.273 Y146.735 E.01598
G1 X130.303 Y150.765 E.17023
G1 X130.838 Y150.765 E.01598
G1 X126.808 Y146.735 E.17023
G1 X127.343 Y146.735 E.01598
G1 X131.372 Y150.765 E.17023
G1 X131.907 Y150.765 E.01598
G1 X127.878 Y146.735 E.17023
G1 X128.412 Y146.735 E.01598
G1 X132.442 Y150.765 E.17023
G1 X132.977 Y150.765 E.01598
G1 X128.947 Y146.735 E.17023
G1 X129.482 Y146.735 E.01598
G1 X133.512 Y150.765 E.17023
G1 X134.046 Y150.765 E.01598
G1 X130.017 Y146.735 E.17023
G1 X130.552 Y146.735 E.01598
G1 X134.581 Y150.765 E.17023
G1 X135.116 Y150.765 E.01598
G1 X131.087 Y146.735 E.17023
G1 X131.621 Y146.735 E.01598
G1 X135.651 Y150.765 E.17023
G1 X136.186 Y150.765 E.01598
G1 X132.156 Y146.735 E.17023
G1 X132.691 Y146.735 E.01598
G1 X136.721 Y150.765 E.17023
G1 X137.255 Y150.765 E.01598
G1 X133.226 Y146.735 E.17023
G1 X133.435 Y146.735 E.00626
G1 X133.435 Y146.41 E.00972
G1 X137.79 Y150.765 E.18398
G1 X138.325 Y150.765 E.01598
G1 X133.435 Y145.875 E.20657
G1 X133.435 Y145.34 E.01598
G1 X138.86 Y150.765 E.22917
G1 X139.395 Y150.765 E.01598
G1 X133.435 Y144.805 E.25176
G1 X133.435 Y144.271 E.01598
G1 X139.929 Y150.765 E.27436
G1 X140.464 Y150.765 E.01598
G1 X133.435 Y143.736 E.29695
G1 X133.435 Y143.201 E.01598
G1 X140.999 Y150.765 E.31954
G1 X141.534 Y150.765 E.01598
G1 X133.435 Y142.666 E.34214
G1 X133.435 Y142.131 E.01598
G1 X142.069 Y150.765 E.36473
G1 X142.603 Y150.765 E.01598
G1 X133.435 Y141.597 E.38733
G1 X133.435 Y141.062 E.01598
G1 X143.138 Y150.765 E.40992
G1 X143.673 Y150.765 E.01598
G1 X133.435 Y140.527 E.43251
G1 X133.435 Y139.992 E.01598
G1 X144.208 Y150.765 E.45511
G1 X144.743 Y150.765 E.01598
G1 X133.435 Y139.457 E.4777
G1 X133.435 Y138.922 E.01598
G1 X145.278 Y150.765 E.5003
G1 X145.812 Y150.765 E.01598
G1 X133.435 Y138.388 E.52289
G1 X133.435 Y137.853 E.01598
G1 X146.347 Y150.765 E.54548
G1 X146.882 Y150.765 E.01598
G1 X133.435 Y137.318 E.56808
G1 X133.435 Y136.783 E.01598
G1 X147.417 Y150.765 E.59067
G1 X147.952 Y150.765 E.01598
G1 X133.435 Y136.248 E.61327
G1 X133.435 Y135.714 E.01598
G1 X148.486 Y150.765 E.63586
G1 X149.021 Y150.765 E.01598
G1 X133.435 Y135.179 E.65845
G1 X133.435 Y134.644 E.01598
G1 X149.556 Y150.765 E.68105
G1 X150.091 Y150.765 E.01598
G1 X133.435 Y134.109 E.70364
G1 X133.435 Y133.574 E.01598
G1 X150.795 Y150.934 E.7334
; WIPE_START
G1 X149.381 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.234 Y145.886 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X129.864 Y122.515 E.98733
G3 X129.926 Y123.112 I-1.609 J.47 E.01803
G1 X153.065 Y146.251 E.97753
G1 X153.065 Y146.786 E.01598
G1 X129.845 Y123.566 E.98096
G3 X129.682 Y123.938 I-.992 J-.213 E.01221
G1 X153.065 Y147.321 E.98785
G1 X153.065 Y147.856 E.01598
G1 X129.463 Y124.254 E.9971
G3 X129.192 Y124.517 I-.798 J-.549 E.01137
G1 X153.065 Y148.391 E1.00855
G1 X153.065 Y148.925 E.01598
G1 X128.861 Y124.722 E1.02251
G3 X128.473 Y124.868 I-.534 J-.828 E.01249
G1 X153.065 Y149.46 E1.03891
G3 X153.029 Y149.959 I-2.541 J.069 E.01497
G1 X127.997 Y124.927 E1.05752
G3 X127.346 Y124.811 I-.042 J-1.652 E.01987
G1 X152.857 Y150.322 E1.07774
G3 X152.586 Y150.586 I-.776 J-.526 E.01138
G1 X118.135 Y116.135 E1.45541
G1 X118.67 Y116.135 E.01598
G1 X126.178 Y123.643 E.31717
G3 X126.067 Y122.997 I1.804 J-.642 E.01966
G1 X119.205 Y116.135 E.2899
G1 X119.74 Y116.135 E.01598
G1 X126.127 Y122.522 E.26982
G3 X126.277 Y122.137 I1.088 J.203 E.01241
G1 X120.275 Y116.135 E.25357
G1 X120.809 Y116.135 E.01598
G1 X126.484 Y121.81 E.23974
G1 X126.689 Y121.572 E.00938
G1 X126.742 Y121.533 E.00197
G1 X121.344 Y116.135 E.22805
G1 X121.879 Y116.135 E.01598
G1 X127.056 Y121.312 E.21869
G3 X127.434 Y121.155 I.601 J.92 E.01231
G1 X122.414 Y116.135 E.21208
G1 X122.949 Y116.135 E.01598
G1 X127.89 Y121.076 E.20874
G3 X128.437 Y121.113 I.177 J1.459 E.01649
G1 X128.474 Y121.126 E.00117
M73 P50 R7
G1 X123.484 Y116.135 E.21084
G1 X124.018 Y116.135 E.01598
G1 X153.065 Y145.182 E1.22711
G1 X153.065 Y144.647 E.01598
G1 X124.553 Y116.135 E1.20451
G1 X125.088 Y116.135 E.01598
G1 X153.065 Y144.112 E1.18192
G1 X153.065 Y143.577 E.01598
G1 X125.623 Y116.135 E1.15933
G1 X126.158 Y116.135 E.01598
G1 X153.065 Y143.042 E1.13673
G1 X153.065 Y142.508 E.01598
G1 X126.692 Y116.135 E1.11414
G1 X127.227 Y116.135 E.01598
G1 X153.065 Y141.973 E1.09154
G1 X153.065 Y141.438 E.01598
G1 X127.762 Y116.135 E1.06895
G1 X128.297 Y116.135 E.01598
G1 X153.065 Y140.903 E1.04636
G1 X153.065 Y140.368 E.01598
G1 X128.832 Y116.135 E1.02376
G1 X129.366 Y116.135 E.01598
G1 X153.065 Y139.834 E1.00117
G1 X153.065 Y139.299 E.01598
G1 X129.901 Y116.135 E.97857
G1 X130.436 Y116.135 E.01598
G1 X153.065 Y138.764 E.95598
G1 X153.065 Y138.229 E.01598
G1 X130.971 Y116.135 E.93339
G1 X131.506 Y116.135 E.01598
G1 X153.234 Y137.864 E.91796
; WIPE_START
G1 X151.82 Y136.45 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.234 Y133.051 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X142.917 Y122.733 E.43589
G3 X142.911 Y123.262 I-1.492 J.248 E.01589
G1 X153.065 Y133.416 E.42897
G1 X153.065 Y133.951 E.01598
G1 X142.801 Y123.687 E.4336
G3 X142.625 Y124.046 I-.974 J-.256 E.01202
G1 X153.065 Y134.485 E.44103
G1 X153.065 Y135.02 E.01598
G1 X142.387 Y124.342 E.45111
G3 X142.099 Y124.589 I-.765 J-.598 E.0114
G1 X153.065 Y135.555 E.46326
G1 X153.065 Y136.09 E.01598
G1 X141.752 Y124.777 E.47794
G1 X141.667 Y124.819 E.00281
G1 X141.342 Y124.902 E.01003
G1 X153.065 Y136.625 E.49524
G1 X153.065 Y137.159 E.01598
G1 X140.631 Y124.726 E.52528
; WIPE_START
G1 X142.045 Y126.14 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.274 Y123.369 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X132.041 Y116.135 E.30558
G1 X132.575 Y116.135 E.01598
G1 X139.099 Y122.659 E.27561
G3 X139.203 Y122.277 I1.211 J.122 E.01188
G1 X139.22 Y122.245 E.00109
G1 X133.11 Y116.135 E.2581
G1 X133.435 Y116.135 E.00971
G1 X133.435 Y115.925 E.00627
G1 X139.408 Y121.898 E.25233
G1 X139.656 Y121.611 E.01133
G1 X133.435 Y115.391 E.26279
G1 X133.435 Y114.856 E.01598
G1 X139.956 Y121.376 E.27547
G1 X140.024 Y121.326 E.00252
G1 X140.308 Y121.194 E.00937
G1 X133.435 Y114.321 E.29034
G1 X133.435 Y113.786 E.01598
G1 X140.731 Y121.082 E.30824
G1 X141.129 Y121.067 E.01187
G1 X141.272 Y121.088 E.00433
G1 X133.435 Y113.251 E.33108
G1 X133.435 Y112.717 E.01598
G1 X153.065 Y132.346 E.82928
G1 X153.065 Y131.811 E.01598
G1 X133.435 Y112.182 E.82928
G1 X133.435 Y111.647 E.01598
G1 X153.065 Y131.277 E.82928
G1 X153.065 Y130.742 E.01598
G1 X133.435 Y111.112 E.82928
G1 X133.435 Y110.577 E.01598
G1 X153.065 Y130.207 E.82928
G1 X153.065 Y129.672 E.01598
G1 X133.435 Y110.043 E.82928
G1 X133.435 Y109.508 E.01598
G1 X153.065 Y129.137 E.82928
G1 X153.065 Y128.602 E.01598
G1 X133.435 Y108.973 E.82928
G1 X133.435 Y108.438 E.01598
G1 X153.065 Y128.068 E.82928
G1 X153.065 Y127.533 E.01598
G1 X133.435 Y107.903 E.82928
G1 X133.435 Y107.368 E.01598
G1 X153.065 Y126.998 E.82928
G1 X153.065 Y126.463 E.01598
G1 X133.435 Y106.834 E.82928
G1 X133.435 Y106.299 E.01598
G1 X153.065 Y125.928 E.82928
G1 X153.065 Y125.394 E.01598
G1 X133.435 Y105.764 E.82928
G1 X133.435 Y105.229 E.01598
G1 X153.065 Y124.859 E.82928
G1 X153.065 Y124.324 E.01598
G1 X133.435 Y104.694 E.82928
G1 X133.435 Y104.16 E.01598
G1 X153.065 Y123.789 E.82928
G1 X153.065 Y123.254 E.01598
G1 X133.435 Y103.625 E.82928
G1 X133.435 Y103.09 E.01598
G1 X153.065 Y122.72 E.82928
G1 X153.065 Y122.185 E.01598
G1 X132.117 Y101.237 E.88497
G1 X132.652 Y101.237 E.01598
G1 X153.065 Y121.65 E.86237
G1 X153.065 Y121.115 E.01598
G1 X133.187 Y101.237 E.83978
G1 X133.722 Y101.237 E.01598
G1 X153.065 Y120.58 E.81718
G1 X153.065 Y120.045 E.01598
G1 X134.256 Y101.237 E.79459
G1 X134.791 Y101.237 E.01598
G1 X153.065 Y119.511 E.77199
G1 X153.065 Y118.976 E.01598
G1 X135.326 Y101.237 E.74939
G1 X135.861 Y101.237 E.01598
G1 X153.065 Y118.441 E.7268
G1 X153.065 Y117.906 E.01598
G1 X136.396 Y101.237 E.7042
G1 X136.931 Y101.237 E.01598
G1 X153.065 Y117.371 E.68161
G1 X153.065 Y116.837 E.01598
G1 X137.466 Y101.237 E.65901
G1 X138 Y101.237 E.01598
G1 X153.065 Y116.302 E.63642
G1 X153.065 Y115.767 E.01598
G1 X138.535 Y101.237 E.61382
G1 X139.07 Y101.237 E.01598
G1 X153.065 Y115.232 E.59123
G1 X153.065 Y114.697 E.01598
G1 X139.605 Y101.237 E.56863
G1 X140.14 Y101.237 E.01598
G1 X153.065 Y114.163 E.54604
M73 P51 R7
G1 X153.065 Y113.628 E.01598
G1 X140.675 Y101.237 E.52344
G1 X141.209 Y101.238 E.01598
G1 X153.065 Y113.093 E.50085
G1 X153.065 Y112.558 E.01598
G1 X141.744 Y101.238 E.47825
G1 X142.279 Y101.238 E.01598
G1 X153.065 Y112.023 E.45566
G1 X153.065 Y111.488 E.01598
G1 X142.814 Y101.238 E.43306
G1 X143.349 Y101.238 E.01598
G1 X153.065 Y110.954 E.41046
G1 X153.065 Y110.419 E.01598
G1 X143.884 Y101.238 E.38787
G1 X144.419 Y101.238 E.01598
G1 X153.065 Y109.884 E.36527
G1 X153.065 Y109.349 E.01598
G1 X144.953 Y101.238 E.34268
G1 X145.488 Y101.238 E.01598
G1 X153.065 Y108.814 E.32008
G1 X153.065 Y108.28 E.01598
G1 X146.023 Y101.238 E.29749
G1 X146.558 Y101.238 E.01598
G1 X153.065 Y107.745 E.27489
G1 X153.065 Y107.21 E.01598
G1 X147.093 Y101.238 E.2523
G1 X147.628 Y101.238 E.01598
G1 X153.065 Y106.675 E.2297
G1 X153.065 Y106.14 E.01598
G1 X148.162 Y101.238 E.20711
G1 X148.697 Y101.238 E.01598
G1 X153.065 Y105.605 E.18451
G1 X153.065 Y105.071 E.01598
G1 X149.232 Y101.238 E.16192
G1 X149.767 Y101.238 E.01598
G1 X153.065 Y104.536 E.13932
G1 X153.065 Y104.001 E.01598
G1 X150.302 Y101.238 E.11673
G1 X150.837 Y101.238 E.01598
G1 X153.065 Y103.466 E.09413
G1 X153.065 Y102.931 E.01598
G1 X151.372 Y101.238 E.07153
G1 X151.906 Y101.238 E.01598
G1 X153.234 Y102.566 E.05611
; WIPE_START
G1 X151.906 Y101.238 E-.71372
G1 X151.785 Y101.238 E-.04628
; WIPE_END
G1 E-.04 F1800
G1 X146.215 Y106.457 Z1.8 F30000
G1 X112.09 Y138.434 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X102.935 Y129.28 E.38674
G1 X102.935 Y129.815 E.01598
G1 X111.385 Y138.265 E.35697
G1 X110.85 Y138.265 E.01598
G1 X102.935 Y130.35 E.33438
G1 X102.935 Y130.885 E.01598
G1 X110.315 Y138.265 E.31179
G1 X109.781 Y138.265 E.01598
G1 X102.935 Y131.419 E.28919
G1 X102.935 Y131.954 E.01598
G1 X109.246 Y138.265 E.2666
G1 X108.711 Y138.265 E.01598
G1 X102.935 Y132.489 E.244
G1 X102.935 Y133.024 E.01598
G1 X108.176 Y138.265 E.22141
G1 X107.641 Y138.265 E.01598
G1 X102.935 Y133.559 E.19882
G1 X102.935 Y134.093 E.01598
G1 X107.107 Y138.265 E.17622
G1 X106.572 Y138.265 E.01598
G1 X102.935 Y134.628 E.15363
G1 X102.935 Y135.163 E.01598
G1 X106.037 Y138.265 E.13104
G1 X105.502 Y138.265 E.01598
G1 X102.935 Y135.698 E.10844
G1 X102.935 Y136.233 E.01598
G1 X105.065 Y138.362 E.08997
G1 X105.065 Y138.897 E.01598
G1 X102.935 Y136.768 E.08997
G1 X102.935 Y137.302 E.01598
G1 X105.065 Y139.432 E.08997
G1 X105.065 Y139.967 E.01598
G1 X102.935 Y137.837 E.08997
G1 X102.935 Y138.372 E.01598
G1 X105.234 Y140.671 E.09713
; WIPE_START
G1 X103.82 Y139.257 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.729 Y146.889 Z1.8 F30000
G1 X103.681 Y150.883 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F15000
G1 X103.259 Y150.461 E.01784
G3 X102.935 Y149.603 I.824 J-.801 E.02818
G1 X104.097 Y150.765 E.04908
G1 X104.632 Y150.765 E.01598
G1 X102.935 Y149.068 E.07167
G1 X102.935 Y148.533 E.01598
G1 X105.167 Y150.765 E.09427
G1 X105.701 Y150.765 E.01598
G1 X102.935 Y147.999 E.11686
G1 X102.935 Y147.464 E.01598
G1 X106.236 Y150.765 E.13945
G1 X106.771 Y150.765 E.01598
G1 X102.935 Y146.929 E.16205
G1 X102.935 Y146.394 E.01598
G1 X107.306 Y150.765 E.18464
G1 X107.841 Y150.765 E.01598
G1 X102.935 Y145.859 E.20724
G1 X102.935 Y145.325 E.01598
G1 X108.375 Y150.765 E.22983
G1 X108.91 Y150.765 E.01598
G1 X102.935 Y144.79 E.25242
G1 X102.935 Y144.255 E.01598
G1 X109.445 Y150.765 E.27502
G1 X109.98 Y150.765 E.01598
G1 X102.935 Y143.72 E.29761
G1 X102.935 Y143.185 E.01598
G1 X110.515 Y150.765 E.32021
G1 X111.05 Y150.765 E.01598
G1 X102.935 Y142.65 E.3428
G1 X102.935 Y142.116 E.01598
G1 X111.584 Y150.765 E.36539
G1 X112.119 Y150.765 E.01598
G1 X102.935 Y141.581 E.38799
G1 X102.935 Y141.046 E.01598
G1 X112.654 Y150.765 E.41058
G1 X113.189 Y150.765 E.01598
G1 X102.935 Y140.511 E.43318
G1 X102.935 Y139.976 E.01598
G1 X113.724 Y150.765 E.45577
G1 X114.258 Y150.765 E.01598
G1 X102.935 Y139.442 E.47836
G1 X102.935 Y138.907 E.01598
G1 X114.793 Y150.765 E.50096
G1 X115.328 Y150.765 E.01598
G1 X105.898 Y141.335 E.39836
G1 X106.433 Y141.335 E.01598
G1 X115.863 Y150.765 E.39836
G1 X116.398 Y150.765 E.01598
G1 X106.968 Y141.335 E.39836
G1 X107.503 Y141.335 E.01598
G1 X116.932 Y150.765 E.39836
G1 X117.467 Y150.765 E.01598
G1 X108.038 Y141.335 E.39836
G1 X108.573 Y141.335 E.01598
G1 X118.172 Y150.934 E.40553
; WIPE_START
G1 X116.758 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.163 Y141.899 Z1.8 F30000
G1 X118.669 Y113.598 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.669 Y104.802 E.28284
G1 X123.33 Y104.802 E.14988
G1 X123.33 Y113.598 E.28284
G1 X118.729 Y113.598 E.14795
M204 S250
G1 X118.277 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.277 Y104.41 E.28536
G1 X123.723 Y104.41 E.16219
G1 X123.723 Y113.99 E.28536
G1 X118.337 Y113.99 E.16041
; WIPE_START
M204 S10000
G1 X118.325 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.129 Y113.139 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55392
G1 F12328.768
G1 X119.129 Y105.321 E.31557
; WIPE_START
G1 X119.129 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-1.143 J.418 P1  F30000
G1 X121.297 Y113.25 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.413 Y113.25 E.03586
G1 X122.413 Y112.737 E.0165
G1 X120.078 Y110.402 E.10619
G1 X120.571 Y110.402 E.01585
G1 X119.587 Y111.385 E.04471
G1 X119.587 Y109.911 E.04737
G1 X119.698 Y110.022 E.00505
G1 X119.698 Y108.394 E.05236
; WIPE_START
G1 X119.698 Y110.022 E-.61876
G1 X119.587 Y109.911 E-.05965
G1 X119.587 Y110.126 E-.08159
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-.823 J.897 P1  F30000
G1 X122.871 Y113.139 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55392
G1 F12328.768
G1 X122.871 Y110.351 E.11254
G1 X122.871 Y110.291 F30000
; LINE_WIDTH: 0.533944
G1 F12830.349
G1 X122.891 Y110.177 E.0045
; LINE_WIDTH: 0.49399
G1 F13966.79
G1 X122.911 Y110.062 E.00413
; LINE_WIDTH: 0.454037
G1 F15000
G1 X122.931 Y109.948 E.00377
; LINE_WIDTH: 0.430898
G2 X122.924 Y108.452 I-25.659 J-.615 E.04586
; LINE_WIDTH: 0.467589
G1 F14835.108
G1 X122.906 Y108.353 E.00339
; LINE_WIDTH: 0.503665
G1 F13673.507
G1 X122.888 Y108.253 E.00368
; LINE_WIDTH: 0.539742
G1 F12680.605
G1 X122.87 Y108.154 E.00397
G1 X122.802 Y108.218 E.00365
; LINE_WIDTH: 0.503665
G1 F13673.507
G1 X122.735 Y108.282 E.00338
; LINE_WIDTH: 0.467589
G1 F14835.108
G1 X122.667 Y108.346 E.00312
; LINE_WIDTH: 0.420327
G1 F15000
G1 X122.523 Y108.39 E.00449
G1 X120.102 Y108.39 E.07219
G2 X120.09 Y109.998 I56.934 J1.209 E.04793
G2 X122.523 Y110.01 I1.621 J-86.158 E.07253
; LINE_WIDTH: 0.435378
G1 X122.647 Y110.073 E.00431
; LINE_WIDTH: 0.466153
G1 F14885.435
G1 X122.771 Y110.136 E.00465
; LINE_WIDTH: 0.499635
G1 F13794.162
G1 X122.805 Y110.188 E.00225
; LINE_WIDTH: 0.535825
G1 F12781.367
G1 X122.839 Y110.24 E.00243
G1 X122.561 Y109.648 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X122.561 Y108.752 E.02671
G1 X122.129 Y108.767 E.01289
G1 X120.467 Y108.767 E.04949
G1 X120.467 Y109.633 E.02577
G1 X122.505 Y109.633 E.06067
; WIPE_START
G1 X120.505 Y109.633 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I.645 J1.032 P1  F30000
G1 X122.87 Y108.154 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.553951
G1 F12328.036
G1 X122.871 Y105.321 E.11435
; WIPE_START
G1 X122.87 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-.84 J-.881 P1  F30000
G1 X120.9 Y109.2 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.5309
G1 F12910.366
G1 X122.069 Y109.2 E.04506
; WIPE_START
G1 X120.9 Y109.2 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-1.215 J-.077 P1  F30000
G1 X118.669 Y144.198 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.669 Y135.402 E.28284
G1 X123.33 Y135.402 E.14988
G1 X123.33 Y144.198 E.28284
G1 X118.729 Y144.198 E.14795
M204 S250
G1 X118.277 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.277 Y135.01 E.28536
G1 X123.723 Y135.01 E.16219
G1 X123.723 Y144.59 E.28536
G1 X118.337 Y144.59 E.16041
; WIPE_START
M204 S10000
G1 X118.325 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.129 Y143.739 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55392
G1 F12328.768
G1 X119.129 Y135.921 E.31557
; WIPE_START
G1 X119.129 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I-.848 J.873 P1  F30000
G1 X122.303 Y141.002 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X120.674 Y141.002 E.05236
G1 X119.587 Y142.088 E.04943
G1 X119.587 Y140.615 E.04737
G1 X122.413 Y143.44 E.12847
G1 X122.413 Y143.85 E.01316
G1 X121.193 Y143.85 E.0392
; WIPE_START
G1 X122.413 Y143.85 E-.46324
G1 X122.413 Y143.44 E-.15552
G1 X122.15 Y143.178 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.871 Y143.739 Z1.8 F30000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55392
G1 F12328.768
G1 X122.871 Y140.951 E.11254
; WIPE_START
G1 X122.871 Y142.951 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I1.032 J-.646 P1  F30000
M73 P52 R7
G1 X120.9 Y139.8 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.5309
G1 F12910.366
G1 X122.069 Y139.8 E.04506
G1 X122.561 Y139.352 F30000
; LINE_WIDTH: 0.41999
G1 F15000
G1 X122.129 Y139.367 E.01289
G1 X120.467 Y139.367 E.04949
G1 X120.467 Y140.233 E.02577
G1 X122.523 Y140.233 E.06124
G1 X122.561 Y140.248 E.00123
G1 X122.561 Y139.412 E.02492
G1 X122.87 Y138.754 F30000
; LINE_WIDTH: 0.539742
G1 F12680.605
G1 X122.802 Y138.818 E.00365
; LINE_WIDTH: 0.503665
G1 F13673.507
G1 X122.735 Y138.882 E.00338
; LINE_WIDTH: 0.467589
G1 F14835.108
G1 X122.667 Y138.946 E.00312
; LINE_WIDTH: 0.420327
G1 F15000
G1 X122.523 Y138.99 E.00449
G1 X120.102 Y138.99 E.07219
G2 X120.09 Y140.598 I56.934 J1.209 E.04793
G2 X122.523 Y140.61 I1.621 J-86.158 E.07253
; LINE_WIDTH: 0.435378
G1 X122.647 Y140.673 E.00431
; LINE_WIDTH: 0.466153
G1 F14885.435
G1 X122.771 Y140.736 E.00465
; LINE_WIDTH: 0.499635
G1 F13794.162
G1 X122.821 Y140.813 E.00333
; LINE_WIDTH: 0.535825
G1 F12781.367
G1 X122.871 Y140.891 E.0036
; LINE_WIDTH: 0.533944
G1 F12830.349
G1 X122.891 Y140.777 E.0045
; LINE_WIDTH: 0.49399
G1 F13966.79
G1 X122.911 Y140.662 E.00413
; LINE_WIDTH: 0.454037
G1 F15000
G1 X122.931 Y140.548 E.00377
; LINE_WIDTH: 0.430898
G2 X122.924 Y139.052 I-25.659 J-.615 E.04586
; LINE_WIDTH: 0.467589
G1 F14835.108
G1 X122.909 Y138.972 E.00272
; LINE_WIDTH: 0.503665
G1 F13673.507
G1 X122.895 Y138.892 E.00295
; LINE_WIDTH: 0.539742
G1 F12680.605
G1 X122.88 Y138.813 E.00318
G1 X122.87 Y138.754 F30000
; LINE_WIDTH: 0.553951
G1 F12328.036
G1 X122.871 Y135.921 E.11435
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12328.036
G1 X122.87 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 8/22
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
G17
G3 Z1.8 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.594 Y122.241
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.698 Y122.061 E.00669
G3 X127.767 Y121.414 I1.297 J.937 E.04126
G1 X127.923 Y121.4 E.00504
G3 X126.553 Y122.303 I.072 J1.599 E.26791
G1 X126.561 Y122.291 E.00046
M204 S250
G1 X126.93 Y122.441 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X127.015 Y122.292 E.00513
G3 X127.822 Y121.803 I.98 J.707 E.02887
G1 X127.94 Y121.792 E.00353
G3 X126.898 Y122.492 I.054 J1.207 E.18682
; WIPE_START
M204 S10000
G1 X127.015 Y122.292 E-.08807
G1 X127.179 Y122.111 E-.09296
G1 X127.393 Y121.953 E-.10105
G1 X127.558 Y121.874 E-.06943
G1 X127.822 Y121.803 E-.10374
G1 X127.94 Y121.792 E-.04509
G1 X128.18 Y121.803 E-.09151
G1 X128.442 Y121.873 E-.10299
G1 X128.597 Y121.948 E-.06517
; WIPE_END
G1 E-.04 F1800
G1 X120.977 Y122.39 Z2 F30000
G1 X116.559 Y122.646 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.593 Y122.881 E.00763
G3 X114.767 Y121.414 I-1.598 J.119 E.23922
G1 X114.923 Y121.4 E.00504
G3 X116.543 Y122.588 I.072 J1.6 E.06985
M204 S250
G1 X116.174 Y122.709 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.201 Y122.91 E.00603
G3 X114.822 Y121.803 I-1.206 J.09 E.16733
G1 X114.94 Y121.792 E.00353
G3 X116.153 Y122.654 I.055 J1.208 E.04777
; WIPE_START
M204 S10000
G1 X116.201 Y122.91 E-.09887
G1 X116.204 Y123.12 E-.07999
G1 X116.156 Y123.357 E-.09157
G1 X116.09 Y123.525 E-.06871
G1 X115.946 Y123.755 E-.103
G1 X115.8 Y123.907 E-.08013
G1 X115.605 Y124.048 E-.09157
G1 X115.357 Y124.156 E-.10297
G1 X115.245 Y124.178 E-.0432
; WIPE_END
G1 E-.04 F1800
G1 X115.26 Y131.81 Z2 F30000
G1 X115.29 Y146.402 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.01261
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y146.402 E.4246
G1 X115.35 Y146.402 E.57084
M204 S250
G1 X115.29 Y146.01 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y146.01 E.36995
G1 X115.35 Y146.01 E.5171
; WIPE_START
M204 S10000
G1 X115.34 Y144.01 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.7 Y140.247 Z2 F30000
G1 X105.79 Y138.598 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.381 Y131.422 Z2 F30000
G1 X110.202 Y107.998 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.002 Y110.934 Z2 F30000
G1 X132.71 Y115.802 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.57277
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y115.802 E.4246
G1 X132.77 Y115.802 E.01068
M204 S250
G1 X132.71 Y115.41 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y115.35 E.36816
; WIPE_START
M204 S10000
G1 X130.71 Y115.357 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.211 Y119.355 Z2 F30000
G1 X142.559 Y122.645 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.593 Y122.881 E.00766
G3 X140.767 Y121.414 I-1.598 J.119 E.23922
G1 X140.923 Y121.4 E.00504
G3 X142.543 Y122.587 I.072 J1.6 E.06982
M204 S250
G1 X142.173 Y122.708 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.201 Y122.91 E.00606
G3 X140.822 Y121.803 I-1.206 J.09 E.16733
G1 X140.94 Y121.792 E.00353
G3 X142.153 Y122.653 I.055 J1.208 E.04775
; WIPE_START
M204 S10000
G1 X142.201 Y122.91 E-.09914
G1 X142.204 Y123.12 E-.07999
G1 X142.156 Y123.357 E-.09157
G1 X142.09 Y123.525 E-.0687
G1 X141.946 Y123.755 E-.103
G1 X141.8 Y123.907 E-.08013
G1 X141.605 Y124.048 E-.09157
G1 X141.357 Y124.156 E-.10297
G1 X141.246 Y124.177 E-.04293
; WIPE_END
G1 E-.04 F1800
G1 X144.4 Y131.128 Z2 F30000
G1 X153.17 Y150.455 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X151.989 Y151.098 I-1.184 J-.768 E.0451
G1 X104.011 Y151.098 E1.54278
G3 X102.602 Y149.689 I-.001 J-1.408 E.07117
G1 X102.602 Y102.311 E1.52354
G3 X104.011 Y100.902 I1.411 J.003 E.07113
G1 X152.069 Y100.905 E1.54537
G3 X153.398 Y102.31 I-.071 J1.398 E.06866
G1 X153.398 Y149.69 E1.52354
G3 X153.202 Y150.404 I-1.411 J-.003 E.0241
M204 S250
G1 X153.501 Y150.665 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.517 J-.981 E.05327
G1 X104.004 Y151.49 E1.42951
G3 X102.21 Y149.696 I.008 J-1.802 E.08383
G1 X102.21 Y102.304 E1.41166
G3 X104.004 Y100.51 I1.806 J.012 E.08379
G1 X152.095 Y100.514 E1.43246
G3 X153.79 Y102.304 I-.097 J1.79 E.08098
G1 X153.79 Y149.696 E1.41166
G3 X153.532 Y150.614 I-1.806 J-.012 E.02873
; WIPE_START
M204 S10000
G1 X153.285 Y150.946 E-.1574
G1 X152.984 Y151.195 E-.14856
G1 X152.724 Y151.336 E-.11214
G1 X152.389 Y151.447 E-.13429
G1 X151.996 Y151.49 E-.15025
G1 X151.845 Y151.49 E-.05736
; WIPE_END
G1 E-.04 F1800
G1 X151.733 Y150.934 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42108
G1 F15000
G1 X153.065 Y149.603 E.05625
G1 X153.065 Y149.068 E.01598
G1 X151.368 Y150.765 E.07167
G1 X150.833 Y150.765 E.01598
G1 X153.065 Y148.533 E.09426
G1 X153.065 Y147.999 E.01598
G1 X150.299 Y150.765 E.11686
G1 X149.764 Y150.765 E.01598
G1 X153.065 Y147.464 E.13945
G1 X153.065 Y146.929 E.01598
G1 X149.229 Y150.765 E.16204
G1 X148.694 Y150.765 E.01598
G1 X153.065 Y146.394 E.18463
G1 X153.065 Y145.859 E.01598
G1 X148.159 Y150.765 E.20723
G1 X147.625 Y150.765 E.01598
G1 X153.065 Y145.325 E.22982
G1 X153.065 Y144.79 E.01598
G1 X147.09 Y150.765 E.25241
G1 X146.555 Y150.765 E.01598
G1 X153.065 Y144.255 E.27501
G1 X153.065 Y143.72 E.01598
G1 X146.02 Y150.765 E.2976
G1 X145.485 Y150.765 E.01598
G1 X153.065 Y143.185 E.32019
G1 X153.065 Y142.651 E.01598
G1 X144.951 Y150.765 E.34278
G1 X144.416 Y150.765 E.01598
G1 X153.065 Y142.116 E.36538
G1 X153.065 Y141.581 E.01598
G1 X143.881 Y150.765 E.38797
G1 X143.346 Y150.765 E.01598
G1 X153.065 Y141.046 E.41056
G1 X153.065 Y140.511 E.01598
G1 X142.811 Y150.765 E.43315
G1 X142.277 Y150.765 E.01598
G1 X153.065 Y139.977 E.45575
G1 X153.065 Y139.442 E.01598
G1 X141.742 Y150.765 E.47834
G1 X141.207 Y150.765 E.01598
G1 X153.065 Y138.907 E.50093
G1 X153.065 Y138.372 E.01598
G1 X140.672 Y150.765 E.52353
M73 P53 R7
G1 X140.137 Y150.765 E.01598
G1 X153.065 Y137.837 E.54612
G1 X153.065 Y137.303 E.01598
G1 X139.603 Y150.765 E.56871
G1 X139.068 Y150.765 E.01598
G1 X153.065 Y136.768 E.5913
G1 X153.065 Y136.233 E.01598
G1 X138.533 Y150.765 E.6139
G1 X137.998 Y150.765 E.01598
G1 X153.065 Y135.698 E.63649
G1 X153.065 Y135.163 E.01598
G1 X137.463 Y150.765 E.65908
G1 X136.929 Y150.765 E.01598
G1 X153.065 Y134.629 E.68167
G1 X153.065 Y134.094 E.01598
G1 X136.394 Y150.765 E.70427
G1 X135.859 Y150.765 E.01598
G1 X153.065 Y133.559 E.72686
G1 X153.065 Y133.024 E.01598
G1 X135.324 Y150.765 E.74945
G1 X134.789 Y150.765 E.01598
G1 X153.065 Y132.489 E.77205
G1 X153.065 Y131.955 E.01598
G1 X134.255 Y150.765 E.79464
G1 X133.72 Y150.765 E.01598
G1 X153.065 Y131.42 E.81723
G1 X153.065 Y130.885 E.01598
G1 X133.185 Y150.765 E.83982
G1 X132.65 Y150.765 E.01598
G1 X153.065 Y130.35 E.86242
G1 X153.065 Y129.815 E.01598
G1 X132.115 Y150.765 E.88501
G1 X131.581 Y150.765 E.01598
G1 X153.065 Y129.281 E.9076
G1 X153.065 Y128.746 E.01598
G1 X131.046 Y150.765 E.93019
G1 X130.511 Y150.765 E.01598
G1 X153.065 Y128.211 E.95279
G1 X153.065 Y127.676 E.01598
G1 X129.976 Y150.765 E.97538
G1 X129.441 Y150.765 E.01598
G1 X153.065 Y127.141 E.99797
G1 X153.065 Y126.607 E.01598
G1 X133.435 Y146.236 E.82926
G1 X133.435 Y145.701 E.01598
G1 X153.065 Y126.072 E.82926
G1 X153.065 Y125.537 E.01598
G1 X133.435 Y145.167 E.82926
G1 X133.435 Y144.632 E.01598
G1 X153.065 Y125.002 E.82926
G1 X153.065 Y124.467 E.01598
G1 X133.435 Y144.097 E.82926
G1 X133.435 Y143.562 E.01598
G1 X153.065 Y123.933 E.82926
G1 X153.065 Y123.398 E.01598
G1 X133.435 Y143.027 E.82926
G1 X133.435 Y142.493 E.01598
G1 X153.065 Y122.863 E.82926
G1 X153.065 Y122.328 E.01598
G1 X133.435 Y141.958 E.82926
G1 X133.435 Y141.423 E.01598
G1 X153.065 Y121.793 E.82926
G1 X153.065 Y121.259 E.01598
G1 X133.435 Y140.888 E.82926
G1 X133.435 Y140.353 E.01598
G1 X153.065 Y120.724 E.82926
G1 X153.065 Y120.189 E.01598
G1 X133.435 Y139.819 E.82926
G1 X133.435 Y139.284 E.01598
G1 X153.065 Y119.654 E.82926
G1 X153.065 Y119.12 E.01598
G1 X133.435 Y138.749 E.82926
G1 X133.435 Y138.214 E.01598
G1 X153.065 Y118.585 E.82926
G1 X153.065 Y118.05 E.01598
G1 X133.435 Y137.679 E.82926
G1 X133.435 Y137.145 E.01598
G1 X153.065 Y117.515 E.82926
G1 X153.065 Y116.98 E.01598
G1 X133.435 Y136.61 E.82926
G1 X133.435 Y136.075 E.01598
G1 X153.065 Y116.446 E.82926
G1 X153.065 Y115.911 E.01598
G1 X133.435 Y135.54 E.82926
G1 X133.435 Y135.005 E.01598
G1 X153.065 Y115.376 E.82926
G1 X153.065 Y114.841 E.01598
G1 X133.435 Y134.471 E.82926
G1 X133.435 Y133.936 E.01598
G1 X153.065 Y114.306 E.82926
G1 X153.065 Y113.772 E.01598
G1 X133.435 Y133.401 E.82926
G1 X133.435 Y132.866 E.01598
G1 X141.416 Y124.886 E.33713
G3 X140.845 Y124.921 I-.394 J-1.748 E.01714
G1 X132.902 Y132.865 E.33557
G1 X132.367 Y132.865 E.01598
G1 X140.397 Y124.835 E.33923
G3 X140.031 Y124.666 I.26 J-1.045 E.01211
G1 X131.832 Y132.865 E.34636
G1 X131.298 Y132.865 E.01598
G1 X139.722 Y124.44 E.35589
G3 X139.462 Y124.165 I.546 J-.775 E.01138
G1 X130.763 Y132.865 E.36751
G1 X130.228 Y132.865 E.01598
G1 X139.261 Y123.832 E.38159
G3 X139.122 Y123.436 I.852 J-.52 E.01263
G1 X129.693 Y132.865 E.39834
G1 X129.158 Y132.865 E.01598
G1 X139.258 Y122.765 E.42668
; WIPE_START
G1 X137.844 Y124.179 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.632 Y123.669 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X153.065 Y113.237 E.44072
G1 X153.065 Y112.702 E.01598
G1 X142.925 Y122.842 E.42838
G2 X142.834 Y122.398 I-1.228 J.02 E.01361
G1 X153.065 Y112.167 E.43222
G1 X153.065 Y111.632 E.01598
G1 X142.673 Y122.024 E.439
G1 X142.447 Y121.715 E.01143
G1 X153.065 Y111.098 E.44856
G1 X153.065 Y110.563 E.01598
G1 X142.168 Y121.46 E.46034
G1 X141.839 Y121.254 E.01159
G1 X153.065 Y110.028 E.47424
G1 X153.065 Y109.493 E.01598
G1 X141.443 Y121.115 E.49097
G2 X140.949 Y121.074 I-.437 J2.264 E.01483
G1 X153.065 Y108.958 E.51182
G1 X153.065 Y108.424 E.01598
G1 X128.624 Y132.865 E1.03253
G1 X128.089 Y132.865 E.01598
G1 X153.065 Y107.889 E1.05512
G1 X153.065 Y107.354 E.01598
G1 X127.554 Y132.865 E1.07771
G1 X127.019 Y132.865 E.01598
G1 X153.065 Y106.819 E1.10031
G1 X153.065 Y106.284 E.01598
G1 X126.484 Y132.865 E1.1229
G1 X125.95 Y132.865 E.01598
G1 X153.065 Y105.75 E1.14549
M73 P54 R7
G1 X153.065 Y105.215 E.01598
G1 X125.415 Y132.865 E1.16808
G1 X124.88 Y132.865 E.01598
G1 X153.065 Y104.68 E1.19068
G1 X153.065 Y104.145 E.01598
G1 X124.345 Y132.865 E1.21327
G1 X123.81 Y132.865 E.01598
G1 X153.065 Y103.61 E1.23586
G1 X153.065 Y103.076 E.01598
G1 X123.276 Y132.865 E1.25846
G1 X122.741 Y132.865 E.01598
G1 X153.065 Y102.541 E1.28105
G2 X153.028 Y102.043 I-2.262 J-.083 E.01494
G1 X122.206 Y132.865 E1.30208
G1 X121.671 Y132.865 E.01598
G1 X152.857 Y101.679 E1.31746
G2 X152.584 Y101.417 I-.835 J.596 E.01136
G1 X121.136 Y132.865 E1.32852
G1 X120.602 Y132.865 E.01598
G1 X128.648 Y124.818 E.33994
G3 X127.995 Y124.937 I-.684 J-1.907 E.01993
G1 X120.067 Y132.865 E.33492
G1 X119.532 Y132.865 E.01598
G1 X127.523 Y124.874 E.33759
G3 X127.139 Y124.723 I.203 J-1.082 E.0124
G1 X118.997 Y132.865 E.34396
G1 X118.462 Y132.865 E.01598
G1 X126.808 Y124.519 E.35256
G3 X126.539 Y124.254 I.567 J-.844 E.01136
G1 X117.928 Y132.865 E.36377
G1 X117.393 Y132.865 E.01598
G1 X126.319 Y123.939 E.37707
G3 X126.157 Y123.566 I.737 J-.541 E.01225
G1 X116.858 Y132.865 E.39284
G1 X116.323 Y132.865 E.01598
G1 X126.072 Y123.116 E.41186
G1 X126.063 Y122.989 E.0038
G1 X126.126 Y122.527 E.01392
G1 X115.788 Y132.865 E.43672
G1 X115.254 Y132.865 E.01598
G1 X131.983 Y116.135 E.70675
G1 X131.448 Y116.135 E.01598
G1 X109.319 Y138.265 E.93487
G1 X109.854 Y138.265 E.01598
G1 X114.565 Y133.554 E.19903
G1 X114.565 Y134.088 E.01598
G1 X110.388 Y138.265 E.17643
G1 X110.923 Y138.265 E.01598
G1 X114.565 Y134.623 E.15384
G1 X114.565 Y135.158 E.01598
G1 X111.458 Y138.265 E.13125
G1 X111.993 Y138.265 E.01598
G1 X114.565 Y135.693 E.10866
G1 X114.565 Y136.228 E.01598
G1 X112.528 Y138.265 E.08606
G1 X112.935 Y138.265 E.01218
G1 X112.935 Y138.392 E.0038
G1 X114.565 Y136.762 E.06884
G1 X114.565 Y137.297 E.01598
G1 X112.935 Y138.927 E.06884
G1 X112.935 Y139.461 E.01598
G1 X114.565 Y137.832 E.06884
G1 X114.565 Y138.367 E.01598
G1 X112.935 Y139.996 E.06884
G1 X112.935 Y140.531 E.01598
G1 X114.565 Y138.902 E.06884
G1 X114.565 Y139.436 E.01598
G1 X103.415 Y150.586 E.47103
G2 X103.797 Y150.739 I.532 J-.78 E.0124
G1 X114.565 Y139.971 E.45487
G1 X114.565 Y140.506 E.01598
G1 X104.306 Y150.765 E.43339
G1 X104.841 Y150.765 E.01598
G1 X114.565 Y141.041 E.41079
G1 X114.565 Y141.576 E.01598
G1 X105.376 Y150.765 E.3882
G1 X105.91 Y150.765 E.01598
G1 X114.565 Y142.11 E.36561
G1 X114.565 Y142.645 E.01598
G1 X106.445 Y150.765 E.34302
G1 X106.98 Y150.765 E.01598
G1 X114.565 Y143.18 E.32042
G1 X114.565 Y143.715 E.01598
G1 X107.515 Y150.765 E.29783
G1 X108.05 Y150.765 E.01598
G1 X114.565 Y144.25 E.27524
G1 X114.565 Y144.784 E.01598
G1 X108.584 Y150.765 E.25265
G1 X109.119 Y150.765 E.01598
G1 X114.565 Y145.319 E.23005
G1 X114.565 Y145.854 E.01598
G1 X109.654 Y150.765 E.20746
G1 X110.189 Y150.765 E.01598
G1 X114.565 Y146.389 E.18487
G1 X114.565 Y146.735 E.01035
G1 X114.753 Y146.735 E.00562
G1 X110.724 Y150.765 E.17023
G1 X111.258 Y150.765 E.01598
G1 X115.288 Y146.735 E.17023
G1 X115.823 Y146.735 E.01598
G1 X111.793 Y150.765 E.17023
G1 X112.328 Y150.765 E.01598
G1 X116.357 Y146.735 E.17023
G1 X116.892 Y146.735 E.01598
G1 X112.863 Y150.765 E.17023
G1 X113.398 Y150.765 E.01598
G1 X117.427 Y146.735 E.17023
G1 X117.962 Y146.735 E.01598
G1 X113.932 Y150.765 E.17023
G1 X114.467 Y150.765 E.01598
G1 X118.497 Y146.735 E.17023
G1 X119.031 Y146.735 E.01598
G1 X115.002 Y150.765 E.17023
G1 X115.537 Y150.765 E.01598
G1 X119.566 Y146.735 E.17023
G1 X120.101 Y146.735 E.01598
G1 X116.072 Y150.765 E.17023
G1 X116.606 Y150.765 E.01598
G1 X120.636 Y146.735 E.17023
G1 X121.171 Y146.735 E.01598
G1 X117.141 Y150.765 E.17023
G1 X117.676 Y150.765 E.01598
G1 X121.705 Y146.735 E.17023
G1 X122.24 Y146.735 E.01598
G1 X118.211 Y150.765 E.17023
G1 X118.745 Y150.765 E.01598
G1 X122.775 Y146.735 E.17023
G1 X123.31 Y146.735 E.01598
G1 X119.28 Y150.765 E.17023
G1 X119.815 Y150.765 E.01598
G1 X123.845 Y146.735 E.17023
G1 X124.379 Y146.735 E.01598
G1 X120.35 Y150.765 E.17023
G1 X120.885 Y150.765 E.01598
G1 X124.914 Y146.735 E.17023
G1 X125.449 Y146.735 E.01598
G1 X121.419 Y150.765 E.17023
G1 X121.954 Y150.765 E.01598
G1 X125.984 Y146.735 E.17023
G1 X126.519 Y146.735 E.01598
G1 X122.489 Y150.765 E.17023
G1 X123.024 Y150.765 E.01598
G1 X127.053 Y146.735 E.17023
G1 X127.588 Y146.735 E.01598
G1 X123.559 Y150.765 E.17023
G1 X124.093 Y150.765 E.01598
G1 X128.123 Y146.735 E.17023
G1 X128.658 Y146.735 E.01598
G1 X124.628 Y150.765 E.17023
G1 X125.163 Y150.765 E.01598
G1 X129.193 Y146.735 E.17023
G1 X129.727 Y146.735 E.01598
G1 X125.698 Y150.765 E.17023
G1 X126.233 Y150.765 E.01598
G1 X130.262 Y146.735 E.17023
G1 X130.797 Y146.735 E.01598
G1 X126.767 Y150.765 E.17023
G1 X127.302 Y150.765 E.01598
G1 X131.332 Y146.735 E.17023
G1 X131.867 Y146.735 E.01598
G1 X127.837 Y150.765 E.17023
G1 X128.372 Y150.765 E.01598
G1 X132.401 Y146.735 E.17023
G1 X132.936 Y146.735 E.01598
G1 X128.737 Y150.934 E.1774
; WIPE_START
G1 X130.151 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.523 Y149.78 Z2 F30000
G1 X103.021 Y150.446 Z2
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X112.131 Y141.335 E.38487
G1 X111.596 Y141.335 E.01598
G1 X102.973 Y149.959 E.36431
G3 X102.935 Y149.461 I2.195 J-.415 E.01493
G1 X111.061 Y141.335 E.3433
G1 X110.527 Y141.335 E.01598
G1 X102.935 Y148.927 E.3207
G1 X102.935 Y148.392 E.01598
G1 X109.992 Y141.335 E.29811
G1 X109.457 Y141.335 E.01598
G1 X102.935 Y147.857 E.27552
G1 X102.935 Y147.322 E.01598
G1 X108.922 Y141.335 E.25293
G1 X108.387 Y141.335 E.01598
G1 X102.935 Y146.787 E.23033
G1 X102.935 Y146.253 E.01598
G1 X107.853 Y141.335 E.20774
G1 X107.318 Y141.335 E.01598
G1 X102.935 Y145.718 E.18515
G1 X102.935 Y145.183 E.01598
G1 X106.783 Y141.335 E.16255
G1 X106.248 Y141.335 E.01598
G1 X102.935 Y144.648 E.13996
G1 X102.935 Y144.113 E.01598
G1 X105.713 Y141.335 E.11737
G1 X105.179 Y141.335 E.01598
G1 X102.935 Y143.579 E.09478
G1 X102.935 Y143.044 E.01598
G1 X105.065 Y140.914 E.08996
G1 X105.065 Y140.38 E.01598
G1 X102.935 Y142.509 E.08996
G1 X102.935 Y141.974 E.01598
G1 X105.065 Y139.845 E.08996
G1 X105.065 Y139.31 E.01598
G1 X102.935 Y141.44 E.08996
G1 X102.935 Y140.905 E.01598
G1 X105.065 Y138.775 E.08996
G1 X105.065 Y138.265 E.01525
G1 X105.575 Y138.265 E.01525
G1 X127.705 Y116.135 E.93487
G1 X128.24 Y116.135 E.01598
G1 X106.11 Y138.265 E.93487
G1 X106.645 Y138.265 E.01598
G1 X128.774 Y116.135 E.93487
G1 X129.309 Y116.135 E.01598
G1 X107.18 Y138.265 E.93487
G1 X107.714 Y138.265 E.01598
G1 X129.844 Y116.135 E.93487
G1 X130.379 Y116.135 E.01598
G1 X108.249 Y138.265 E.93487
G1 X108.784 Y138.265 E.01598
G1 X131.083 Y115.966 E.94204
; WIPE_START
G1 X129.669 Y117.38 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P55 R7
G1 X133.266 Y115.922 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X147.95 Y101.238 E.62035
G1 X147.415 Y101.238 E.01597
G1 X133.435 Y115.218 E.59059
G1 X133.435 Y114.683 E.01598
G1 X146.881 Y101.238 E.568
G1 X146.346 Y101.238 E.01597
G1 X133.435 Y114.148 E.54541
G1 X133.435 Y113.614 E.01598
G1 X145.811 Y101.238 E.52282
G1 X145.276 Y101.238 E.01597
G1 X133.435 Y113.079 E.50023
G1 X133.435 Y112.544 E.01598
G1 X144.741 Y101.238 E.47763
G1 X144.207 Y101.238 E.01597
G1 X133.435 Y112.009 E.45504
G1 X133.435 Y111.474 E.01598
G1 X143.672 Y101.238 E.43245
G1 X143.137 Y101.238 E.01597
G1 X133.435 Y110.94 E.40986
G1 X133.435 Y110.405 E.01598
G1 X142.602 Y101.238 E.38727
G1 X142.068 Y101.238 E.01597
G1 X133.435 Y109.87 E.36468
G1 X133.435 Y109.335 E.01598
G1 X141.533 Y101.237 E.34209
G1 X140.998 Y101.237 E.01597
G1 X133.435 Y108.8 E.31949
G1 X133.435 Y108.266 E.01598
G1 X140.463 Y101.237 E.2969
G1 X139.929 Y101.237 E.01597
G1 X133.435 Y107.731 E.27431
G1 X133.435 Y107.196 E.01598
G1 X139.394 Y101.237 E.25172
G1 X138.859 Y101.237 E.01597
G1 X133.435 Y106.661 E.22913
G1 X133.435 Y106.126 E.01598
G1 X138.324 Y101.237 E.20654
G1 X137.789 Y101.237 E.01597
G1 X133.435 Y105.592 E.18395
G1 X133.435 Y105.057 E.01598
G1 X137.255 Y101.237 E.16136
G1 X136.72 Y101.237 E.01597
G1 X133.435 Y104.522 E.13876
G1 X133.435 Y103.987 E.01598
G1 X136.185 Y101.237 E.11617
G1 X135.65 Y101.237 E.01597
G1 X133.435 Y103.452 E.09358
G1 X133.435 Y102.918 E.01598
G1 X135.116 Y101.237 E.07099
G1 X134.581 Y101.237 E.01597
G1 X133.435 Y102.383 E.0484
G1 X133.435 Y102.265 E.00352
G1 X133.018 Y102.265 E.01245
G1 X134.046 Y101.237 E.04342
G1 X133.511 Y101.237 E.01597
G1 X132.484 Y102.265 E.04342
G1 X131.949 Y102.265 E.01598
G1 X132.977 Y101.237 E.04342
G1 X132.442 Y101.237 E.01597
G1 X131.414 Y102.265 E.04342
G1 X130.879 Y102.265 E.01598
G1 X131.907 Y101.237 E.04342
G1 X131.372 Y101.237 E.01597
G1 X130.344 Y102.265 E.04342
G1 X129.81 Y102.265 E.01598
G1 X130.838 Y101.237 E.04342
G1 X130.303 Y101.237 E.01597
G1 X129.275 Y102.265 E.04343
G1 X128.74 Y102.265 E.01598
G1 X129.768 Y101.237 E.04343
G1 X129.233 Y101.237 E.01597
G1 X128.205 Y102.265 E.04343
G1 X127.67 Y102.265 E.01598
G1 X128.698 Y101.237 E.04343
G1 X128.164 Y101.237 E.01597
G1 X127.136 Y102.265 E.04343
G1 X126.601 Y102.265 E.01598
G1 X127.629 Y101.237 E.04343
G1 X127.094 Y101.237 E.01597
G1 X126.066 Y102.265 E.04343
G1 X125.531 Y102.265 E.01598
G1 X126.559 Y101.237 E.04344
G1 X126.025 Y101.237 E.01597
G1 X124.996 Y102.265 E.04344
G1 X124.462 Y102.265 E.01598
G1 X125.49 Y101.237 E.04344
G1 X124.955 Y101.236 E.01597
G1 X123.927 Y102.265 E.04344
G1 X123.392 Y102.265 E.01598
G1 X124.42 Y101.236 E.04344
G1 X123.886 Y101.236 E.01597
G1 X122.857 Y102.265 E.04344
G1 X122.322 Y102.265 E.01598
G1 X123.351 Y101.236 E.04344
G1 X122.816 Y101.236 E.01597
G1 X121.788 Y102.265 E.04345
G1 X121.253 Y102.265 E.01598
G1 X122.281 Y101.236 E.04345
G1 X121.746 Y101.236 E.01597
G1 X120.718 Y102.265 E.04345
G1 X120.183 Y102.265 E.01598
G1 X121.212 Y101.236 E.04345
G1 X120.677 Y101.236 E.01597
G1 X119.648 Y102.265 E.04345
G1 X119.114 Y102.265 E.01598
G1 X120.142 Y101.236 E.04345
G1 X119.607 Y101.236 E.01597
G1 X118.579 Y102.265 E.04345
G1 X118.044 Y102.265 E.01598
G1 X119.073 Y101.236 E.04346
G1 X118.538 Y101.236 E.01597
G1 X117.509 Y102.265 E.04346
G1 X116.974 Y102.265 E.01598
G1 X118.003 Y101.236 E.04346
G1 X117.468 Y101.236 E.01597
G1 X116.44 Y102.265 E.04346
G1 X115.905 Y102.265 E.01598
G1 X116.934 Y101.236 E.04346
G1 X116.399 Y101.236 E.01597
G1 X115.2 Y102.434 E.05063
G1 X114.734 Y102.9 F30000
G1 F15000
G1 X110.535 Y107.1 E.1774
G1 X110.535 Y107.634 E.01598
G1 X114.565 Y103.605 E.17023
G1 X114.565 Y104.14 E.01598
G1 X111.04 Y107.665 E.14892
G1 X111.574 Y107.665 E.01598
G1 X114.565 Y104.674 E.12633
G1 X114.565 Y105.209 E.01598
G1 X112.109 Y107.665 E.10374
G1 X112.644 Y107.665 E.01598
G1 X114.565 Y105.744 E.08114
G1 X114.565 Y106.279 E.01598
G1 X112.935 Y107.908 E.06884
G1 X112.935 Y108.443 E.01598
G1 X114.565 Y106.814 E.06884
G1 X114.565 Y107.348 E.01598
G1 X112.935 Y108.978 E.06884
G1 X112.935 Y109.513 E.01598
G1 X114.565 Y107.883 E.06884
G1 X114.565 Y108.418 E.01598
G1 X112.766 Y110.217 E.07601
; WIPE_START
G1 X114.18 Y108.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.366 Y111.013 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X110.643 Y110.735 E.01173
G1 X111.178 Y110.735 E.01598
G1 X110.535 Y111.378 E.02715
G1 X110.535 Y111.913 E.01598
G1 X111.713 Y110.735 E.04975
G1 X112.248 Y110.735 E.01598
G1 X110.366 Y112.617 E.07951
; WIPE_START
G1 X111.78 Y111.203 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.366 Y106.734 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X115.864 Y101.236 E.23229
G1 X115.329 Y101.236 E.01597
G1 X110.535 Y106.03 E.20253
G1 X110.535 Y105.495 E.01598
G1 X114.795 Y101.236 E.17994
G1 X114.26 Y101.236 E.01597
G1 X110.231 Y105.265 E.1702
G1 X109.696 Y105.265 E.01598
G1 X113.725 Y101.236 E.1702
G1 X113.19 Y101.236 E.01597
G1 X109.161 Y105.265 E.17021
G1 X108.626 Y105.265 E.01598
G1 X112.655 Y101.236 E.17021
G1 X112.121 Y101.236 E.01597
G1 X107.922 Y105.434 E.17738
; WIPE_START
M73 P55 R6
G1 X109.336 Y104.02 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.126 Y107.834 Z2 F30000
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X107.465 Y107.496 E.0143
G1 X107.465 Y106.961 E.01598
G1 X106.761 Y107.665 E.02972
G1 X106.226 Y107.665 E.01598
G1 X107.465 Y106.426 E.05231
G1 X107.465 Y105.892 E.01598
G1 X105.522 Y107.834 E.08208
G1 X105.234 Y108.122 F30000
G1 F15000
G1 X102.935 Y110.421 E.09713
G1 X102.935 Y110.956 E.01598
G1 X105.065 Y108.826 E.08996
G1 X105.065 Y109.361 E.01598
G1 X102.935 Y111.491 E.08996
G1 X102.935 Y112.026 E.01598
G1 X105.065 Y109.896 E.08996
G1 X105.065 Y110.431 E.01598
G1 X102.935 Y112.56 E.08996
G1 X102.935 Y113.095 E.01598
G1 X105.295 Y110.735 E.0997
G1 X105.83 Y110.735 E.01598
G1 X102.935 Y113.63 E.12229
G1 X102.935 Y114.165 E.01598
G1 X106.365 Y110.735 E.14488
G1 X106.9 Y110.735 E.01598
G1 X102.935 Y114.7 E.16748
G1 X102.935 Y115.234 E.01598
G1 X107.434 Y110.735 E.19007
G1 X107.465 Y110.735 E.00091
G1 X107.465 Y111.24 E.01507
G1 X102.935 Y115.769 E.19135
G1 X102.935 Y116.304 E.01598
G1 X107.465 Y111.774 E.19135
G1 X107.465 Y112.309 E.01598
G1 X102.935 Y116.839 E.19135
G1 X102.935 Y117.374 E.01598
G1 X107.465 Y112.844 E.19135
G1 X107.465 Y113.135 E.0087
G1 X107.708 Y113.135 E.00728
G1 X102.935 Y117.908 E.20164
G1 X102.935 Y118.443 E.01598
G1 X108.243 Y113.135 E.22424
G1 X108.778 Y113.135 E.01598
G1 X102.935 Y118.978 E.24683
G1 X102.935 Y119.513 E.01598
G1 X109.313 Y113.135 E.26942
G1 X109.848 Y113.135 E.01598
G1 X102.935 Y120.048 E.29201
G1 X102.935 Y120.582 E.01598
G1 X114.565 Y108.953 E.49129
G1 X114.565 Y109.488 E.01598
G1 X102.935 Y121.117 E.49129
G1 X102.935 Y121.652 E.01598
G1 X114.565 Y110.022 E.49129
G1 X114.565 Y110.557 E.01598
G1 X102.935 Y122.187 E.49129
G1 X102.935 Y122.722 E.01598
G1 X114.565 Y111.092 E.49129
G1 X114.565 Y111.627 E.01598
G1 X102.935 Y123.256 E.49129
G1 X102.935 Y123.791 E.01598
G1 X114.565 Y112.162 E.49129
G1 X114.565 Y112.696 E.01598
G1 X102.935 Y124.326 E.49129
G1 X102.935 Y124.861 E.01598
G1 X114.565 Y113.231 E.49129
G1 X114.565 Y113.766 E.01598
G1 X102.935 Y125.396 E.49129
G1 X102.935 Y125.93 E.01598
G1 X114.565 Y114.301 E.49129
G1 X114.565 Y114.836 E.01598
G1 X102.935 Y126.465 E.49129
G1 X102.935 Y127 E.01598
G1 X114.565 Y115.37 E.49129
G1 X114.565 Y115.905 E.01598
G1 X102.935 Y127.535 E.49129
G1 X102.935 Y128.07 E.01598
G1 X114.87 Y116.135 E.50417
G1 X115.404 Y116.135 E.01598
G1 X102.935 Y128.604 E.52676
G1 X102.935 Y129.139 E.01598
G1 X115.939 Y116.135 E.54935
G1 X116.474 Y116.135 E.01598
G1 X102.935 Y129.674 E.57195
G1 X102.935 Y130.209 E.01598
G1 X117.009 Y116.135 E.59454
G1 X117.544 Y116.135 E.01598
G1 X102.935 Y130.744 E.61713
G1 X102.935 Y131.278 E.01598
G1 X118.078 Y116.135 E.63972
G1 X118.613 Y116.135 E.01598
G1 X102.935 Y131.813 E.66232
G1 X102.935 Y132.348 E.01598
G1 X119.148 Y116.135 E.68491
G1 X119.683 Y116.135 E.01598
G1 X114.736 Y121.082 E.20898
G1 X115.129 Y121.067 E.01176
G1 X115.266 Y121.087 E.00412
G1 X120.218 Y116.135 E.2092
G1 X120.752 Y116.135 E.01598
G1 X115.687 Y121.2 E.21398
G3 X116.045 Y121.377 I-.254 J.966 E.01201
G1 X121.287 Y116.135 E.22144
G1 X121.822 Y116.135 E.01598
G1 X116.343 Y121.614 E.23147
G3 X116.587 Y121.905 I-.554 J.713 E.01143
G1 X122.357 Y116.135 E.24376
G1 X122.892 Y116.135 E.01598
G1 X116.78 Y122.247 E.25817
G1 X116.903 Y122.659 E.01284
G1 X123.426 Y116.135 E.27558
G1 X123.961 Y116.135 E.01598
G1 X116.727 Y123.37 E.30562
; WIPE_START
G1 X118.141 Y121.955 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.314 Y122.504 Z2 F30000
G1 Z1.6
M73 P56 R6
G1 E.8 F1800
G1 F15000
G1 X102.935 Y132.883 E.43844
G1 X102.935 Y133.418 E.01598
G1 X113.084 Y123.269 E.42873
G1 X113.192 Y123.696 E.01316
G1 X102.935 Y133.952 E.43328
G1 X102.935 Y134.487 E.01598
G1 X113.373 Y124.05 E.44093
G1 X113.612 Y124.346 E.01136
G1 X102.935 Y135.022 E.45103
G1 X102.935 Y135.557 E.01598
G1 X113.899 Y124.593 E.46317
G1 X114.247 Y124.78 E.0118
G1 X102.935 Y136.092 E.47786
G1 X102.935 Y136.626 E.01598
G1 X114.661 Y124.901 E.49535
G2 X115.173 Y124.924 I.317 J-1.36 E.0154
G1 X102.935 Y137.161 E.51698
G1 X102.935 Y137.696 E.01598
G1 X124.496 Y116.135 E.91084
G1 X125.031 Y116.135 E.01598
G1 X102.935 Y138.231 E.93343
G1 X102.935 Y138.766 E.01598
G1 X125.566 Y116.135 E.95602
G1 X126.1 Y116.135 E.01598
G1 X102.935 Y139.3 E.97862
G1 X102.935 Y139.835 E.01598
G1 X126.635 Y116.135 E1.00121
G1 X127.17 Y116.135 E.01598
G1 X102.766 Y140.54 E1.03097
; WIPE_START
G1 X104.18 Y139.125 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.732 Y135.211 Z2 F30000
G1 X129.413 Y124.053 Z2
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X152.207 Y101.259 E.96295
G2 X151.693 Y101.238 I-.337 J1.947 E.0154
G1 X129.936 Y122.995 E.91915
G2 X129.868 Y122.528 I-1.278 J-.053 E.01418
G1 X151.159 Y101.238 E.89942
G1 X150.624 Y101.238 E.01597
G1 X129.727 Y122.135 E.88281
G2 X129.517 Y121.81 I-.968 J.395 E.01162
G1 X150.089 Y101.238 E.86909
G1 X149.554 Y101.238 E.01597
G1 X129.255 Y121.537 E.85754
G2 X128.942 Y121.315 I-.742 J.717 E.01153
G1 X149.02 Y101.238 E.84818
G1 X148.485 Y101.238 E.01597
G1 X128.565 Y121.158 E.84152
G2 X128.121 Y121.067 I-.686 J2.233 E.01357
G1 X133.053 Y116.135 E.20835
G1 X132.518 Y116.135 E.01598
G1 X127.244 Y121.409 E.22279
; WIPE_START
G1 X128.658 Y119.995 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.533 Y117.26 Z2 F30000
G1 X102.766 Y110.056 Z2
G1 Z1.6
G1 E.8 F1800
G1 F15000
G1 X111.586 Y101.236 E.37262
G1 X111.051 Y101.236 E.01597
G1 X102.935 Y109.352 E.34286
G1 X102.935 Y108.817 E.01598
G1 X110.516 Y101.236 E.32027
G1 X109.982 Y101.236 E.01597
G1 X102.935 Y108.282 E.29768
G1 X102.935 Y107.747 E.01598
G1 X109.447 Y101.236 E.27509
G1 X108.912 Y101.236 E.01597
G1 X102.935 Y107.212 E.25249
G1 X102.935 Y106.678 E.01598
G1 X108.377 Y101.235 E.2299
G1 X107.843 Y101.235 E.01597
G1 X102.935 Y106.143 E.20731
G1 X102.935 Y105.608 E.01598
G1 X107.308 Y101.235 E.18472
G1 X106.773 Y101.235 E.01597
G1 X102.935 Y105.073 E.16213
G1 X102.935 Y104.538 E.01598
G1 X106.238 Y101.235 E.13954
G1 X105.703 Y101.235 E.01597
G1 X102.935 Y104.004 E.11695
G1 X102.935 Y103.469 E.01598
G1 X105.169 Y101.235 E.09435
G1 X104.634 Y101.235 E.01597
G1 X102.935 Y102.934 E.07176
G1 X102.935 Y102.399 E.01598
G1 X104.099 Y101.235 E.04917
G2 X103.245 Y101.555 I-.059 J1.145 E.02803
G1 X102.809 Y101.991 E.01841
; WIPE_START
G1 X103.245 Y101.555 E-.23422
G1 X103.419 Y101.41 E-.08636
G1 X103.571 Y101.328 E-.06546
G1 X103.764 Y101.264 E-.07741
G1 X104.099 Y101.235 E-.12768
G1 X103.785 Y101.549 E-.16887
; WIPE_END
G1 E-.04 F1800
G1 X109.737 Y106.328 Z2 F30000
G1 X118.792 Y113.598 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.792 Y104.802 E.28284
G1 X123.208 Y104.802 E.142
G1 X123.208 Y113.598 E.28284
G1 X118.852 Y113.598 E.14007
M204 S250
G1 X118.4 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.4 Y104.41 E.28536
G1 X123.6 Y104.41 E.15489
G1 X123.6 Y113.99 E.28536
G1 X118.46 Y113.99 E.1531
; WIPE_START
M204 S10000
G1 X118.448 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.251 Y113.139 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X119.251 Y105.321 E.31557
; WIPE_START
G1 X119.251 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.297 Y113.25 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.29 Y113.25 E.03192
G1 X122.29 Y112.614 E.02044
G1 X119.71 Y110.034 E.11732
G1 X119.71 Y111.262 E.03949
G1 X122.29 Y108.682 E.11732
G1 X122.29 Y107.054 E.05236
; WIPE_START
G1 X122.29 Y108.682 E-.61876
G1 X122.027 Y108.945 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.749 Y113.139 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.749 Y105.321 E.31557
; WIPE_START
G1 X122.749 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.935 Y114.91 Z2 F30000
G1 X118.792 Y144.198 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.792 Y135.402 E.28284
G1 X123.208 Y135.402 E.142
G1 X123.208 Y144.198 E.28284
G1 X118.852 Y144.198 E.14007
M204 S250
G1 X118.4 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.4 Y135.01 E.28536
G1 X123.6 Y135.01 E.15489
G1 X123.6 Y144.59 E.28536
G1 X118.46 Y144.59 E.1531
; WIPE_START
M204 S10000
G1 X118.448 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.251 Y143.739 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X119.251 Y135.921 E.31557
; WIPE_START
G1 X119.251 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.194 Y143.85 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.29 Y143.85 E.03526
G1 X122.29 Y143.318 E.0171
G1 X119.71 Y140.738 E.11732
G1 X119.71 Y141.966 E.03949
G1 X122.29 Y139.386 E.11732
G1 X122.29 Y137.758 E.05236
; WIPE_START
G1 X122.29 Y139.386 E-.61876
G1 X122.027 Y139.649 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.749 Y143.739 Z2 F30000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.749 Y135.921 E.31557
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
G1 X122.749 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 9/22
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
G17
G3 Z2 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.573 Y122.286
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X126.608 Y122.199 E.00299
G3 X127.767 Y121.414 I1.387 J.799 E.0466
G1 X127.928 Y121.399 E.00518
G3 X126.467 Y122.521 I.067 J1.599 E.26026
G1 X126.548 Y122.34 E.00637
M204 S250
G1 X126.931 Y122.442 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.948 Y122.394 E.00151
G3 X127.822 Y121.803 I1.046 J.605 E.03251
G1 X127.944 Y121.792 E.00366
G3 X126.84 Y122.64 I.05 J1.207 E.18198
G1 X126.906 Y122.496 E.00472
; WIPE_START
M204 S10000
G1 X126.948 Y122.394 E-.04205
G1 X127.02 Y122.29 E-.04795
G1 X127.179 Y122.111 E-.0911
G1 X127.393 Y121.953 E-.101
G1 X127.59 Y121.862 E-.08259
G1 X127.822 Y121.803 E-.09074
G1 X127.944 Y121.792 E-.04665
G1 X128.18 Y121.803 E-.08989
G1 X128.442 Y121.873 E-.10298
G1 X128.596 Y121.948 E-.06504
; WIPE_END
G1 E-.04 F1800
G1 X120.977 Y122.396 Z2.2 F30000
G1 X116.561 Y122.656 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X116.59 Y122.881 E.00729
G3 X114.767 Y121.414 I-1.596 J.118 E.23894
G1 X114.928 Y121.399 E.00518
G3 X116.544 Y122.598 I.067 J1.599 E.06997
M204 S250
G1 X116.175 Y122.72 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.199 Y122.91 E.0057
G3 X114.822 Y121.803 I-1.205 J.089 E.16711
G1 X114.944 Y121.792 E.00366
G3 X116.155 Y122.664 I.05 J1.207 E.04791
; WIPE_START
M204 S10000
G1 X116.199 Y122.91 E-.09496
G1 X116.207 Y123.094 E-.06979
G1 X116.157 Y123.355 E-.10099
G1 X116.09 Y123.525 E-.06954
G1 X115.946 Y123.755 E-.10299
G1 X115.797 Y123.91 E-.08176
G1 X115.605 Y124.048 E-.08991
G1 X115.357 Y124.156 E-.103
G1 X115.235 Y124.179 E-.04706
; WIPE_END
G1 E-.04 F1800
G1 X115.254 Y131.812 Z2.2 F30000
G1 X115.29 Y146.402 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y146.402 E.01261
G1 X114.898 Y133.198 E.4246
G1 X133.102 Y133.198 E.58538
G1 X133.102 Y146.402 E.4246
G1 X115.35 Y146.402 E.57084
M204 S250
G1 X115.29 Y146.01 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y146.01 E.36995
M73 P57 R6
G1 X115.35 Y146.01 E.5171
; WIPE_START
M204 S10000
G1 X115.34 Y144.01 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.7 Y140.247 Z2.2 F30000
G1 X105.79 Y138.598 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y138.598 E.21905
G1 X112.602 Y141.002 E.07731
G1 X105.398 Y141.002 E.23166
G1 X105.398 Y138.598 E.07731
G1 X105.73 Y138.598 E.01068
M204 S250
G1 X105.79 Y138.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.381 Y131.422 Z2.2 F30000
G1 X110.202 Y107.998 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X112.602 Y107.998 E.07718
G1 X112.602 Y110.402 E.07731
G1 X110.202 Y110.402 E.07718
G1 X110.202 Y112.802 E.07718
G1 X107.798 Y112.802 E.07731
G1 X107.798 Y110.402 E.07718
G1 X105.398 Y110.402 E.07718
G1 X105.398 Y107.998 E.07731
G1 X107.798 Y107.998 E.07718
G1 X107.798 Y105.598 E.07718
G1 X110.202 Y105.598 E.07731
G1 X110.202 Y107.938 E.07525
M204 S250
G1 X109.81 Y108.39 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.002 Y110.934 Z2.2 F30000
G1 X132.71 Y115.802 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X114.898 Y115.802 E.57277
G1 X114.898 Y102.598 E.4246
G1 X133.102 Y102.598 E.58538
G1 X133.102 Y115.802 E.4246
G1 X132.77 Y115.802 E.01068
M204 S250
G1 X132.71 Y115.41 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y115.41 E.51888
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y115.35 E.36816
; WIPE_START
M204 S10000
G1 X130.71 Y115.357 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.21 Y119.358 Z2.2 F30000
G1 X142.56 Y122.652 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X142.59 Y122.881 E.00742
G3 X140.767 Y121.414 I-1.596 J.118 E.23894
G1 X140.928 Y121.399 E.00518
G3 X142.543 Y122.595 I.067 J1.599 E.06985
M204 S250
G1 X142.174 Y122.716 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.199 Y122.91 E.00581
G3 X140.822 Y121.803 I-1.205 J.089 E.16711
G1 X140.944 Y121.792 E.00366
G3 X142.154 Y122.661 I.05 J1.207 E.0478
; WIPE_START
M204 S10000
G1 X142.199 Y122.91 E-.09632
G1 X142.207 Y123.094 E-.06979
G1 X142.157 Y123.355 E-.10099
G1 X142.09 Y123.525 E-.06954
G1 X141.946 Y123.755 E-.10299
G1 X141.797 Y123.91 E-.08176
G1 X141.605 Y124.048 E-.08991
G1 X141.357 Y124.156 E-.103
G1 X141.239 Y124.179 E-.0457
; WIPE_END
G1 E-.04 F1800
G1 X144.396 Y131.128 Z2.2 F30000
G1 X153.174 Y150.45 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G3 X151.989 Y151.098 I-1.186 J-.762 E.04531
G1 X104.011 Y151.098 E1.54279
G3 X102.602 Y149.69 I-.001 J-1.408 E.07116
G1 X102.602 Y102.31 E1.52354
G3 X104.011 Y100.902 I1.41 J.002 E.07114
G1 X152.082 Y100.905 E1.5458
G3 X153.398 Y102.31 I-.085 J1.398 E.06824
G1 X153.398 Y149.69 E1.52354
G3 X153.206 Y150.399 I-1.41 J-.002 E.0239
M204 S250
G1 X153.505 Y150.659 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.519 J-.973 E.05349
G1 X104.004 Y151.49 E1.42951
G3 X102.21 Y149.696 I.008 J-1.802 E.08383
G1 X102.21 Y102.304 E1.41167
G3 X104.004 Y100.51 I1.804 J.011 E.0838
G1 X152.109 Y100.514 E1.43288
G3 X153.79 Y102.304 I-.111 J1.789 E.08057
G1 X153.79 Y149.696 E1.41167
G3 X153.536 Y150.608 I-1.804 J-.011 E.02852
; WIPE_START
M204 S10000
G1 X153.281 Y150.95 E-.16215
G1 X152.98 Y151.197 E-.14795
G1 X152.735 Y151.331 E-.10619
G1 X152.387 Y151.447 E-.13942
G1 X151.996 Y151.49 E-.14952
G1 X151.852 Y151.49 E-.05477
; WIPE_END
G1 E-.04 F1800
G1 X152.346 Y150.881 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42109
G1 F15000
G1 X117.601 Y116.135 E1.46787
G1 X117.066 Y116.135 E.01598
G1 X151.696 Y150.765 E1.46297
G1 X151.161 Y150.765 E.01598
G1 X116.362 Y115.966 E1.47014
; WIPE_START
G1 X117.776 Y117.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.089 Y110.697 Z2.2 F30000
G1 X112.509 Y107.834 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X110.535 Y105.861 E.08339
G1 X110.535 Y106.395 E.01598
G1 X111.805 Y107.665 E.05362
G1 X111.27 Y107.665 E.01598
G1 X110.535 Y106.93 E.03103
G1 X110.535 Y107.465 E.01598
G1 X110.905 Y107.834 E.0156
; WIPE_START
G1 X110.535 Y107.465 E-.1985
G1 X110.535 Y106.93 E-.20323
G1 X111.202 Y107.597 E-.35828
; WIPE_END
G1 E-.04 F1800
G1 X110.109 Y105.434 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X105.91 Y101.235 E.1774
G1 X105.375 Y101.235 E.01598
G1 X109.405 Y105.265 E.17023
G1 X108.87 Y105.265 E.01598
G1 X104.84 Y101.235 E.17023
G1 X104.305 Y101.235 E.01598
G1 X108.335 Y105.265 E.17023
G1 X107.8 Y105.265 E.01598
G1 X103.796 Y101.26 E.16917
G2 X103.418 Y101.411 I.184 J1.009 E.01222
G1 X107.465 Y105.464 E.17109
G1 X107.465 Y105.999 E.01598
G1 X103.144 Y101.678 E.18254
G2 X102.973 Y102.042 I.782 J.59 E.01209
G1 X107.465 Y106.534 E.18977
G1 X107.465 Y107.069 E.01598
G1 X102.935 Y102.539 E.19136
G1 X102.935 Y103.074 E.01598
G1 X107.465 Y107.604 E.19136
G1 X107.465 Y107.665 E.00183
G1 X106.991 Y107.665 E.01415
G1 X102.935 Y103.609 E.17135
G1 X102.935 Y104.144 E.01598
G1 X106.456 Y107.665 E.14876
G1 X105.922 Y107.665 E.01598
G1 X102.935 Y104.678 E.12616
G1 X102.935 Y105.213 E.01598
G1 X105.387 Y107.665 E.10357
G1 X105.065 Y107.665 E.00962
G1 X105.065 Y107.878 E.00636
G1 X102.935 Y105.748 E.08997
G1 X102.935 Y106.283 E.01598
G1 X105.065 Y108.412 E.08997
G1 X105.065 Y108.947 E.01598
G1 X102.935 Y106.818 E.08997
G1 X102.935 Y107.352 E.01598
G1 X105.065 Y109.482 E.08997
G1 X105.065 Y110.017 E.01598
G1 X102.935 Y107.887 E.08997
G1 X102.935 Y108.422 E.01598
G1 X127.378 Y132.865 E1.03262
G1 X127.913 Y132.865 E.01598
G1 X108.183 Y113.135 E.8335
G1 X108.718 Y113.135 E.01598
G1 X128.448 Y132.865 E.8335
G1 X128.982 Y132.865 E.01598
G1 X109.253 Y113.135 E.8335
G1 X109.788 Y113.135 E.01598
G1 X129.517 Y132.865 E.8335
G1 X130.052 Y132.865 E.01598
G1 X110.322 Y113.135 E.8335
G1 X110.535 Y113.135 E.00636
G1 X110.535 Y112.813 E.00962
G1 X130.587 Y132.865 E.84711
G1 X131.122 Y132.865 E.01598
G1 X110.366 Y112.109 E.87687
; WIPE_START
G1 X111.78 Y113.523 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.634 Y112.587 Z2.2 F30000
M73 P58 R6
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X105.783 Y110.735 E.07821
G1 X106.318 Y110.735 E.01598
G1 X107.465 Y111.882 E.04845
G1 X107.465 Y111.347 E.01598
G1 X106.853 Y110.735 E.02585
G1 X107.388 Y110.735 E.01598
G1 X107.634 Y110.982 E.01043
; WIPE_START
G1 X107.388 Y110.735 E-.13266
G1 X106.853 Y110.735 E-.20323
G1 X107.465 Y111.347 E-.32888
G1 X107.465 Y111.598 E-.09523
; WIPE_END
G1 E-.04 F1800
G1 X114.642 Y109 Z2.2 F30000
G1 X132.78 Y102.434 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X131.583 Y101.237 E.05058
G1 X131.048 Y101.237 E.01598
G1 X132.076 Y102.265 E.04341
G1 X131.541 Y102.265 E.01598
G1 X130.513 Y101.237 E.04342
G1 X129.978 Y101.237 E.01598
G1 X131.006 Y102.265 E.04342
G1 X130.471 Y102.265 E.01598
G1 X129.443 Y101.237 E.04342
G1 X128.909 Y101.237 E.01598
G1 X129.936 Y102.265 E.04342
G1 X129.401 Y102.265 E.01598
G1 X128.374 Y101.237 E.04342
G1 X127.839 Y101.237 E.01598
G1 X128.867 Y102.265 E.04342
G1 X128.332 Y102.265 E.01598
G1 X127.304 Y101.237 E.04343
G1 X126.769 Y101.237 E.01598
G1 X127.797 Y102.265 E.04343
G1 X127.262 Y102.265 E.01598
G1 X126.234 Y101.237 E.04343
G1 X125.699 Y101.237 E.01598
G1 X126.727 Y102.265 E.04343
G1 X126.193 Y102.265 E.01598
G1 X125.165 Y101.237 E.04343
G1 X124.63 Y101.237 E.01598
G1 X125.658 Y102.265 E.04343
G1 X125.123 Y102.265 E.01598
G1 X124.095 Y101.237 E.04344
G1 X123.56 Y101.237 E.01598
G1 X124.588 Y102.265 E.04344
G1 X124.053 Y102.265 E.01598
G1 X123.025 Y101.237 E.04344
G1 X122.49 Y101.237 E.01598
G1 X123.519 Y102.265 E.04344
G1 X122.984 Y102.265 E.01598
G1 X121.955 Y101.236 E.04344
G1 X121.421 Y101.236 E.01598
G1 X122.449 Y102.265 E.04344
G1 X121.914 Y102.265 E.01598
G1 X120.886 Y101.236 E.04344
G1 X120.351 Y101.236 E.01598
G1 X121.379 Y102.265 E.04345
G1 X120.844 Y102.265 E.01598
G1 X119.816 Y101.236 E.04345
G1 X119.281 Y101.236 E.01598
G1 X120.31 Y102.265 E.04345
G1 X119.775 Y102.265 E.01598
G1 X118.746 Y101.236 E.04345
G1 X118.211 Y101.236 E.01598
G1 X119.24 Y102.265 E.04345
G1 X118.705 Y102.265 E.01598
G1 X117.677 Y101.236 E.04345
G1 X117.142 Y101.236 E.01598
G1 X118.17 Y102.265 E.04346
G1 X117.636 Y102.265 E.01598
G1 X116.607 Y101.236 E.04346
G1 X116.072 Y101.236 E.01598
G1 X117.101 Y102.265 E.04346
G1 X116.566 Y102.265 E.01598
G1 X115.537 Y101.236 E.04346
G1 X115.002 Y101.236 E.01598
G1 X116.031 Y102.265 E.04346
G1 X115.496 Y102.265 E.01598
G1 X114.468 Y101.236 E.04346
G1 X113.933 Y101.236 E.01598
G1 X114.962 Y102.265 E.04347
G1 X114.565 Y102.265 E.01185
G1 X114.565 Y102.403 E.00412
G1 X113.398 Y101.236 E.0493
G1 X112.863 Y101.236 E.01598
G1 X114.565 Y102.938 E.07189
G1 X114.565 Y103.472 E.01598
G1 X112.328 Y101.236 E.09449
G1 X111.793 Y101.236 E.01598
G1 X114.565 Y104.007 E.11709
G1 X114.565 Y104.542 E.01598
G1 X111.258 Y101.236 E.13968
G1 X110.724 Y101.236 E.01598
G1 X114.565 Y105.077 E.16228
G1 X114.565 Y105.612 E.01598
G1 X110.189 Y101.236 E.18487
G1 X109.654 Y101.236 E.01598
G1 X114.565 Y106.147 E.20747
G1 X114.565 Y106.681 E.01598
G1 X109.119 Y101.236 E.23006
G1 X108.584 Y101.236 E.01598
G1 X114.565 Y107.216 E.25266
G1 X114.565 Y107.751 E.01598
G1 X108.049 Y101.236 E.27525
G1 X107.514 Y101.235 E.01598
G1 X114.565 Y108.286 E.29785
G1 X114.565 Y108.821 E.01598
G1 X106.98 Y101.235 E.32044
G1 X106.445 Y101.235 E.01598
G1 X114.565 Y109.355 E.34304
G1 X114.565 Y109.89 E.01598
G1 X112.935 Y108.261 E.06884
G1 X112.935 Y108.795 E.01598
G1 X114.565 Y110.425 E.06884
G1 X114.565 Y110.96 E.01598
G1 X112.935 Y109.33 E.06884
G1 X112.935 Y109.865 E.01598
G1 X114.565 Y111.495 E.06884
G1 X114.565 Y112.029 E.01598
G1 X112.935 Y110.4 E.06884
G1 X112.935 Y110.735 E.01002
G1 X112.736 Y110.735 E.00596
G1 X114.565 Y112.564 E.07727
G1 X114.565 Y113.099 E.01598
G1 X112.201 Y110.735 E.09986
G1 X111.666 Y110.735 E.01598
G1 X114.565 Y113.634 E.12246
G1 X114.565 Y114.169 E.01598
G1 X111.131 Y110.735 E.14505
G1 X110.596 Y110.735 E.01598
G1 X114.565 Y114.704 E.16765
G1 X114.565 Y115.238 E.01598
G1 X110.535 Y111.209 E.17023
G1 X110.535 Y111.744 E.01598
G1 X114.565 Y115.773 E.17023
G1 X114.565 Y116.135 E.01082
G1 X114.927 Y116.135 E.01082
G1 X131.656 Y132.865 E.70676
G1 X132.191 Y132.865 E.01598
G1 X115.462 Y116.135 E.70676
G1 X115.996 Y116.135 E.01598
G1 X132.896 Y133.034 E.71393
; WIPE_START
G1 X131.481 Y131.62 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.013 Y133.034 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X116.933 Y122.955 E.42583
G1 X116.882 Y123.438 E.01452
G1 X126.308 Y132.865 E.39824
G1 X125.773 Y132.865 E.01598
G1 X116.739 Y123.83 E.38167
G3 X116.54 Y124.166 I-.982 J-.356 E.01173
G1 X125.239 Y132.865 E.36749
G1 X124.704 Y132.865 E.01598
G1 X116.285 Y124.446 E.35565
G1 X115.976 Y124.672 E.01143
G1 X124.169 Y132.865 E.34611
G1 X123.634 Y132.865 E.01598
G1 X115.606 Y124.836 E.33917
G1 X115.577 Y124.849 E.00094
G3 X115.156 Y124.921 I-.401 J-1.076 E.01284
G1 X123.099 Y132.865 E.33559
G1 X122.565 Y132.865 E.01598
G1 X114.323 Y124.624 E.34816
; WIPE_START
G1 X115.738 Y126.038 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.232 Y121.254 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X102.935 Y108.957 E.5195
G1 X102.935 Y109.492 E.01598
G1 X114.565 Y121.122 E.49132
G2 X114.168 Y121.26 I.166 J1.118 E.01263
G1 X102.935 Y110.027 E.47455
G1 X102.935 Y110.561 E.01598
G1 X113.837 Y121.463 E.46058
G2 X113.559 Y121.72 I.462 J.781 E.01139
G1 X102.935 Y111.096 E.44881
G1 X102.935 Y111.631 E.01598
G1 X113.333 Y122.029 E.43927
G2 X113.17 Y122.401 I.814 J.579 E.01221
G1 X102.935 Y112.166 E.43239
G1 X102.935 Y112.701 E.01598
G1 X113.079 Y122.844 E.42853
G2 X113.119 Y123.419 I1.645 J.174 E.0173
G1 X102.935 Y113.235 E.43022
G1 X102.935 Y113.77 E.01598
G1 X122.03 Y132.865 E.80668
G1 X121.495 Y132.865 E.01598
G1 X102.935 Y114.305 E.78408
G1 X102.935 Y114.84 E.01598
G1 X120.96 Y132.865 E.76149
G1 X120.425 Y132.865 E.01598
G1 X102.935 Y115.375 E.73889
G1 X102.935 Y115.909 E.01598
G1 X119.891 Y132.865 E.7163
G1 X119.356 Y132.865 E.01598
G1 X102.935 Y116.444 E.69371
G1 X102.935 Y116.979 E.01598
G1 X118.821 Y132.865 E.67111
G1 X118.286 Y132.865 E.01598
G1 X102.935 Y117.514 E.64852
G1 X102.935 Y118.049 E.01598
G1 X117.751 Y132.865 E.62592
G1 X117.216 Y132.865 E.01598
G1 X102.935 Y118.584 E.60333
G1 X102.935 Y119.118 E.01598
G1 X116.682 Y132.865 E.58074
G1 X116.147 Y132.865 E.01598
G1 X102.935 Y119.653 E.55814
G1 X102.935 Y120.188 E.01598
G1 X115.612 Y132.865 E.53555
G1 X115.077 Y132.865 E.01598
G1 X102.935 Y120.723 E.51295
G1 X102.935 Y121.258 E.01598
G1 X114.565 Y132.887 E.49131
G1 X114.565 Y133.422 E.01598
G1 X102.935 Y121.792 E.49131
G1 X102.935 Y122.327 E.01598
G1 X114.565 Y133.957 E.49131
G1 X114.565 Y134.492 E.01598
G1 X102.935 Y122.862 E.49131
G1 X102.935 Y123.397 E.01598
G1 X114.565 Y135.026 E.49131
G1 X114.565 Y135.561 E.01598
G1 X102.935 Y123.932 E.49131
G1 X102.935 Y124.466 E.01598
G1 X114.565 Y136.096 E.49131
G1 X114.565 Y136.631 E.01598
G1 X102.935 Y125.001 E.49131
G1 X102.935 Y125.536 E.01598
G1 X114.565 Y137.166 E.49131
G1 X114.565 Y137.7 E.01598
G1 X102.935 Y126.071 E.49131
G1 X102.935 Y126.606 E.01598
G1 X114.565 Y138.235 E.49131
G1 X114.565 Y138.77 E.01598
G1 X102.935 Y127.141 E.49131
G1 X102.935 Y127.675 E.01598
G1 X114.565 Y139.305 E.49131
G1 X114.565 Y139.84 E.01598
G1 X102.935 Y128.21 E.49131
G1 X102.935 Y128.745 E.01598
G1 X112.455 Y138.265 E.40218
G1 X112.935 Y138.265 E.01435
G1 X112.935 Y138.745 E.01435
G1 X114.565 Y140.375 E.06884
G1 X114.565 Y140.909 E.01598
G1 X112.935 Y139.28 E.06884
G1 X112.935 Y139.815 E.01598
G1 X114.565 Y141.444 E.06884
G1 X114.565 Y141.979 E.01598
G1 X112.935 Y140.349 E.06884
G1 X112.935 Y140.884 E.01598
G1 X114.565 Y142.514 E.06884
G1 X114.565 Y143.049 E.01598
G1 X112.851 Y141.335 E.07238
G1 X112.317 Y141.335 E.01598
G1 X114.565 Y143.583 E.09498
G1 X114.565 Y144.118 E.01598
G1 X111.782 Y141.335 E.11757
G1 X111.247 Y141.335 E.01598
G1 X114.565 Y144.653 E.14017
G1 X114.565 Y145.188 E.01598
G1 X110.712 Y141.335 E.16276
G1 X110.177 Y141.335 E.01598
G1 X114.565 Y145.723 E.18535
G1 X114.565 Y146.257 E.01598
G1 X109.643 Y141.335 E.20795
G1 X109.108 Y141.335 E.01598
G1 X118.537 Y150.765 E.39836
G1 X119.072 Y150.765 E.01598
G1 X115.043 Y146.735 E.17023
M73 P59 R6
G1 X115.577 Y146.735 E.01598
G1 X119.607 Y150.765 E.17023
G1 X120.142 Y150.765 E.01598
G1 X116.112 Y146.735 E.17023
G1 X116.647 Y146.735 E.01598
G1 X120.676 Y150.765 E.17023
G1 X121.211 Y150.765 E.01598
G1 X117.182 Y146.735 E.17023
G1 X117.717 Y146.735 E.01598
G1 X121.746 Y150.765 E.17023
G1 X122.281 Y150.765 E.01598
G1 X118.251 Y146.735 E.17023
G1 X118.786 Y146.735 E.01598
G1 X122.816 Y150.765 E.17023
G1 X123.351 Y150.765 E.01598
G1 X119.321 Y146.735 E.17023
G1 X119.856 Y146.735 E.01598
G1 X123.885 Y150.765 E.17023
G1 X124.42 Y150.765 E.01598
G1 X120.391 Y146.735 E.17023
G1 X120.925 Y146.735 E.01598
G1 X124.955 Y150.765 E.17023
G1 X125.49 Y150.765 E.01598
G1 X121.46 Y146.735 E.17023
G1 X121.995 Y146.735 E.01598
G1 X126.025 Y150.765 E.17023
G1 X126.559 Y150.765 E.01598
G1 X122.53 Y146.735 E.17023
G1 X123.065 Y146.735 E.01598
G1 X127.094 Y150.765 E.17023
G1 X127.629 Y150.765 E.01598
G1 X123.6 Y146.735 E.17023
G1 X124.134 Y146.735 E.01598
G1 X128.164 Y150.765 E.17023
G1 X128.699 Y150.765 E.01598
G1 X124.669 Y146.735 E.17023
G1 X125.204 Y146.735 E.01598
G1 X129.234 Y150.765 E.17023
G1 X129.768 Y150.765 E.01598
G1 X125.739 Y146.735 E.17023
G1 X126.274 Y146.735 E.01598
G1 X130.303 Y150.765 E.17023
G1 X130.838 Y150.765 E.01598
G1 X126.808 Y146.735 E.17023
G1 X127.343 Y146.735 E.01598
G1 X131.373 Y150.765 E.17023
G1 X131.908 Y150.765 E.01598
G1 X127.878 Y146.735 E.17023
G1 X128.413 Y146.735 E.01598
G1 X132.442 Y150.765 E.17023
G1 X132.977 Y150.765 E.01598
G1 X128.948 Y146.735 E.17023
G1 X129.482 Y146.735 E.01598
G1 X133.512 Y150.765 E.17023
G1 X134.047 Y150.765 E.01598
G1 X130.017 Y146.735 E.17023
G1 X130.552 Y146.735 E.01598
G1 X134.582 Y150.765 E.17023
G1 X135.116 Y150.765 E.01598
G1 X131.087 Y146.735 E.17023
G1 X131.622 Y146.735 E.01598
G1 X135.651 Y150.765 E.17023
G1 X136.186 Y150.765 E.01598
G1 X132.157 Y146.735 E.17023
G1 X132.691 Y146.735 E.01598
G1 X136.721 Y150.765 E.17023
G1 X137.256 Y150.765 E.01598
G1 X133.226 Y146.735 E.17023
G1 X133.435 Y146.735 E.00625
G1 X133.435 Y146.409 E.00973
G1 X137.791 Y150.765 E.184
G1 X138.325 Y150.765 E.01598
G1 X133.435 Y145.875 E.20659
G1 X133.435 Y145.34 E.01598
G1 X138.86 Y150.765 E.22918
G1 X139.395 Y150.765 E.01598
G1 X133.435 Y144.805 E.25178
G1 X133.435 Y144.27 E.01598
G1 X139.93 Y150.765 E.27437
G1 X140.465 Y150.765 E.01598
G1 X133.435 Y143.735 E.29696
G1 X133.435 Y143.201 E.01598
G1 X140.999 Y150.765 E.31956
G1 X141.534 Y150.765 E.01598
G1 X133.435 Y142.666 E.34215
G1 X133.435 Y142.131 E.01598
G1 X142.069 Y150.765 E.36475
G1 X142.604 Y150.765 E.01598
G1 X133.435 Y141.596 E.38734
G1 X133.435 Y141.061 E.01598
G1 X143.139 Y150.765 E.40993
G1 X143.673 Y150.765 E.01598
G1 X133.435 Y140.527 E.43253
G1 X133.435 Y139.992 E.01598
G1 X144.208 Y150.765 E.45512
G1 X144.743 Y150.765 E.01598
G1 X133.435 Y139.457 E.47772
G1 X133.435 Y138.922 E.01598
G1 X145.278 Y150.765 E.50031
G1 X145.813 Y150.765 E.01598
G1 X133.435 Y138.387 E.5229
G1 X133.435 Y137.852 E.01598
G1 X146.348 Y150.765 E.5455
G1 X146.882 Y150.765 E.01598
G1 X133.435 Y137.318 E.56809
G1 X133.435 Y136.783 E.01598
G1 X147.417 Y150.765 E.59069
G1 X147.952 Y150.765 E.01598
G1 X133.435 Y136.248 E.61328
G1 X133.435 Y135.713 E.01598
G1 X148.487 Y150.765 E.63587
G1 X149.022 Y150.765 E.01598
G1 X133.435 Y135.178 E.65847
G1 X133.435 Y134.644 E.01598
G1 X149.556 Y150.765 E.68106
G1 X150.091 Y150.765 E.01598
G1 X133.435 Y134.109 E.70366
G1 X133.435 Y133.574 E.01598
G1 X150.796 Y150.934 E.73342
; WIPE_START
G1 X149.381 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.234 Y145.886 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X129.865 Y122.516 E.98728
G3 X129.926 Y123.112 I-1.657 J.471 E.01799
G1 X153.065 Y146.251 E.97752
G1 X153.065 Y146.786 E.01598
G1 X129.845 Y123.565 E.98097
G3 X129.682 Y123.938 I-.987 J-.208 E.01222
G1 X153.065 Y147.321 E.98783
G1 X153.065 Y147.855 E.01598
G1 X129.467 Y124.258 E.99692
G3 X129.192 Y124.518 I-1.171 J-.963 E.01133
G1 X153.065 Y148.39 E1.00854
G1 X153.065 Y148.925 E.01598
G1 X128.864 Y124.724 E1.02241
G3 X128.477 Y124.872 I-.585 J-.95 E.01244
G1 X153.065 Y149.46 E1.03875
G3 X153.027 Y149.957 I-2.155 J.088 E.01493
G1 X127.997 Y124.927 E1.05744
G3 X127.354 Y124.818 I-.037 J-1.741 E.01961
G1 X152.856 Y150.321 E1.0774
G3 X152.586 Y150.585 I-.753 J-.5 E.01138
G1 X118.136 Y116.135 E1.4554
G1 X118.671 Y116.135 E.01598
G1 X126.179 Y123.644 E.3172
G3 X126.063 Y122.993 I1.652 J-.63 E.01986
G1 X119.205 Y116.135 E.28972
G1 X119.74 Y116.135 E.01598
G1 X126.127 Y122.522 E.26983
G3 X126.276 Y122.137 I1.015 J.171 E.01244
G1 X120.275 Y116.135 E.25354
G1 X120.81 Y116.135 E.01598
G1 X126.482 Y121.807 E.23961
G1 X126.743 Y121.533 E.0113
G1 X121.345 Y116.135 E.22805
G1 X121.879 Y116.135 E.01598
G1 X127.056 Y121.312 E.21868
G3 X127.434 Y121.155 I.603 J.92 E.0123
G1 X122.414 Y116.135 E.21206
G1 X122.949 Y116.135 E.01598
G1 X127.89 Y121.076 E.20874
G3 X128.437 Y121.113 I.176 J1.464 E.01647
G1 X128.475 Y121.126 E.0012
G1 X123.484 Y116.135 E.21085
G1 X124.019 Y116.135 E.01598
G1 X153.065 Y145.181 E1.22709
G1 X153.065 Y144.647 E.01598
G1 X124.553 Y116.135 E1.2045
G1 X125.088 Y116.135 E.01598
G1 X153.065 Y144.112 E1.18191
G1 X153.065 Y143.577 E.01598
G1 X125.623 Y116.135 E1.15931
G1 X126.158 Y116.135 E.01598
G1 X153.065 Y143.042 E1.13672
G1 X153.065 Y142.507 E.01598
G1 X126.693 Y116.135 E1.11412
G1 X127.228 Y116.135 E.01598
G1 X153.065 Y141.972 E1.09153
G1 X153.065 Y141.438 E.01598
G1 X127.762 Y116.135 E1.06894
G1 X128.297 Y116.135 E.01598
G1 X153.065 Y140.903 E1.04634
G1 X153.065 Y140.368 E.01598
G1 X128.832 Y116.135 E1.02375
G1 X129.367 Y116.135 E.01598
G1 X153.065 Y139.833 E1.00115
G1 X153.065 Y139.298 E.01598
G1 X129.902 Y116.135 E.97856
G1 X130.436 Y116.135 E.01598
G1 X153.065 Y138.764 E.95597
M73 P60 R6
G1 X153.065 Y138.229 E.01598
G1 X130.971 Y116.135 E.93337
G1 X131.506 Y116.135 E.01598
G1 X153.234 Y137.864 E.91795
; WIPE_START
G1 X151.82 Y136.449 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.234 Y133.05 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X142.916 Y122.732 E.43591
G3 X142.911 Y123.262 I-1.51 J.251 E.01591
G1 X153.065 Y133.415 E.42894
G1 X153.065 Y133.95 E.01598
G1 X142.807 Y123.693 E.43334
G1 X142.625 Y124.046 E.01186
G1 X153.065 Y134.485 E.44103
G1 X153.065 Y135.02 E.01598
G1 X142.39 Y124.346 E.45095
G3 X142.096 Y124.586 I-.982 J-.9 E.01139
G1 X153.065 Y135.555 E.46338
G1 X153.065 Y136.089 E.01598
G1 X141.749 Y124.774 E.47804
G3 X141.343 Y124.903 I-.543 J-1.01 E.0128
G1 X153.065 Y136.624 E.4952
G1 X153.065 Y137.159 E.01598
G1 X140.631 Y124.726 E.52526
; WIPE_START
G1 X142.046 Y126.14 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.283 Y123.378 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X132.041 Y116.135 E.30597
G1 X132.576 Y116.135 E.01598
G1 X139.099 Y122.659 E.2756
G1 X139.108 Y122.578 E.00244
G1 X139.223 Y122.248 E.01043
G1 X133.11 Y116.135 E.25824
G1 X133.435 Y116.135 E.0097
G1 X133.435 Y115.925 E.00628
G1 X139.41 Y121.9 E.25242
G1 X139.656 Y121.611 E.01133
G1 X133.435 Y115.39 E.26279
G1 X133.435 Y114.856 E.01598
G1 X139.956 Y121.376 E.27547
G1 X140.023 Y121.327 E.00248
G1 X140.309 Y121.194 E.00942
G1 X133.435 Y114.321 E.29039
G1 X133.435 Y113.786 E.01598
G1 X140.732 Y121.082 E.30824
G1 X141.13 Y121.067 E.0119
G1 X141.272 Y121.088 E.00431
G1 X133.435 Y113.251 E.33109
G1 X133.435 Y112.716 E.01598
G1 X153.065 Y132.346 E.82928
G1 X153.065 Y131.811 E.01598
G1 X133.435 Y112.181 E.82928
G1 X133.435 Y111.647 E.01598
G1 X153.065 Y131.276 E.82928
G1 X153.065 Y130.741 E.01598
G1 X133.435 Y111.112 E.82928
G1 X133.435 Y110.577 E.01598
G1 X153.065 Y130.207 E.82928
G1 X153.065 Y129.672 E.01598
G1 X133.435 Y110.042 E.82928
G1 X133.435 Y109.507 E.01598
G1 X153.065 Y129.137 E.82928
G1 X153.065 Y128.602 E.01598
G1 X133.435 Y108.973 E.82928
G1 X133.435 Y108.438 E.01598
G1 X153.065 Y128.067 E.82928
G1 X153.065 Y127.532 E.01598
G1 X133.435 Y107.903 E.82928
G1 X133.435 Y107.368 E.01598
G1 X153.065 Y126.998 E.82928
G1 X153.065 Y126.463 E.01598
G1 X133.435 Y106.833 E.82928
G1 X133.435 Y106.299 E.01598
G1 X153.065 Y125.928 E.82928
G1 X153.065 Y125.393 E.01598
G1 X133.435 Y105.764 E.82928
G1 X133.435 Y105.229 E.01598
G1 X153.065 Y124.858 E.82928
G1 X153.065 Y124.324 E.01598
G1 X133.435 Y104.694 E.82928
G1 X133.435 Y104.159 E.01598
G1 X153.065 Y123.789 E.82928
G1 X153.065 Y123.254 E.01598
G1 X133.435 Y103.624 E.82928
G1 X133.435 Y103.09 E.01598
G1 X153.065 Y122.719 E.82928
G1 X153.065 Y122.184 E.01598
G1 X132.118 Y101.237 E.88494
G1 X132.652 Y101.237 E.01598
G1 X153.065 Y121.65 E.86235
G1 X153.065 Y121.115 E.01598
G1 X133.187 Y101.237 E.83975
G1 X133.722 Y101.237 E.01598
G1 X153.065 Y120.58 E.81716
G1 X153.065 Y120.045 E.01598
G1 X134.257 Y101.237 E.79456
G1 X134.792 Y101.237 E.01598
G1 X153.065 Y119.51 E.77196
G1 X153.065 Y118.975 E.01598
G1 X135.327 Y101.237 E.74937
G1 X135.862 Y101.237 E.01598
G1 X153.065 Y118.441 E.72677
G1 X153.065 Y117.906 E.01598
G1 X136.396 Y101.237 E.70418
G1 X136.931 Y101.238 E.01598
G1 X153.065 Y117.371 E.68158
G1 X153.065 Y116.836 E.01598
G1 X137.466 Y101.238 E.65899
G1 X138.001 Y101.238 E.01598
G1 X153.065 Y116.301 E.63639
G1 X153.065 Y115.767 E.01598
G1 X138.536 Y101.238 E.6138
G1 X139.071 Y101.238 E.01598
G1 X153.065 Y115.232 E.5912
G1 X153.065 Y114.697 E.01598
G1 X139.606 Y101.238 E.56861
G1 X140.14 Y101.238 E.01598
G1 X153.065 Y114.162 E.54601
G1 X153.065 Y113.627 E.01598
G1 X140.675 Y101.238 E.52341
G1 X141.21 Y101.238 E.01598
G1 X153.065 Y113.093 E.50082
G1 X153.065 Y112.558 E.01598
G1 X141.745 Y101.238 E.47822
G1 X142.28 Y101.238 E.01598
G1 X153.065 Y112.023 E.45563
G1 X153.065 Y111.488 E.01598
G1 X142.815 Y101.238 E.43303
G1 X143.349 Y101.238 E.01598
G1 X153.065 Y110.953 E.41044
G1 X153.065 Y110.418 E.01598
G1 X143.884 Y101.238 E.38784
G1 X144.419 Y101.238 E.01598
G1 X153.065 Y109.884 E.36525
G1 X153.065 Y109.349 E.01598
G1 X144.954 Y101.238 E.34265
G1 X145.489 Y101.238 E.01598
G1 X153.065 Y108.814 E.32005
G1 X153.065 Y108.279 E.01598
G1 X146.024 Y101.238 E.29746
G1 X146.559 Y101.238 E.01598
G1 X153.065 Y107.744 E.27486
G1 X153.065 Y107.21 E.01598
G1 X147.093 Y101.238 E.25227
G1 X147.628 Y101.238 E.01598
G1 X153.065 Y106.675 E.22967
G1 X153.065 Y106.14 E.01598
G1 X148.163 Y101.238 E.20708
G1 X148.698 Y101.238 E.01598
G1 X153.065 Y105.605 E.18448
G1 X153.065 Y105.07 E.01598
G1 X149.233 Y101.238 E.16189
G1 X149.768 Y101.238 E.01598
G1 X153.065 Y104.536 E.13929
G1 X153.065 Y104.001 E.01598
G1 X150.303 Y101.238 E.11669
G1 X150.837 Y101.239 E.01598
G1 X153.065 Y103.466 E.0941
G1 X153.065 Y102.931 E.01598
G1 X151.372 Y101.239 E.0715
G1 X151.907 Y101.239 E.01598
G1 X153.234 Y102.566 E.05608
; WIPE_START
G1 X151.907 Y101.239 E-.71333
G1 X151.784 Y101.239 E-.04667
; WIPE_END
G1 E-.04 F1800
G1 X146.215 Y106.457 Z2.2 F30000
G1 X112.09 Y138.434 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X102.935 Y129.28 E.38675
G1 X102.935 Y129.815 E.01598
G1 X111.385 Y138.265 E.35699
G1 X110.851 Y138.265 E.01598
G1 X102.935 Y130.349 E.3344
G1 X102.935 Y130.884 E.01598
M73 P61 R6
G1 X110.316 Y138.265 E.3118
G1 X109.781 Y138.265 E.01598
G1 X102.935 Y131.419 E.28921
G1 X102.935 Y131.954 E.01598
G1 X109.246 Y138.265 E.26661
G1 X108.711 Y138.265 E.01598
G1 X102.935 Y132.489 E.24402
G1 X102.935 Y133.023 E.01598
G1 X108.176 Y138.265 E.22143
G1 X107.642 Y138.265 E.01598
G1 X102.935 Y133.558 E.19883
G1 X102.935 Y134.093 E.01598
G1 X107.107 Y138.265 E.17624
G1 X106.572 Y138.265 E.01598
G1 X102.935 Y134.628 E.15364
G1 X102.935 Y135.163 E.01598
G1 X106.037 Y138.265 E.13105
G1 X105.502 Y138.265 E.01598
G1 X102.935 Y135.698 E.10846
G1 X102.935 Y136.232 E.01598
G1 X105.065 Y138.362 E.08997
G1 X105.065 Y138.897 E.01598
G1 X102.935 Y136.767 E.08997
G1 X102.935 Y137.302 E.01598
G1 X105.065 Y139.432 E.08997
G1 X105.065 Y139.966 E.01598
G1 X102.935 Y137.837 E.08997
G1 X102.935 Y138.372 E.01598
G1 X105.234 Y140.671 E.09713
; WIPE_START
G1 X103.82 Y139.257 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.729 Y146.889 Z2.2 F30000
G1 X103.681 Y150.884 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F15000
G1 X103.243 Y150.445 E.01854
G3 X102.935 Y149.603 I.856 J-.79 E.02749
G1 X104.097 Y150.765 E.04909
G1 X104.632 Y150.765 E.01598
G1 X102.935 Y149.068 E.07169
G1 X102.935 Y148.533 E.01598
G1 X105.167 Y150.765 E.09428
G1 X105.702 Y150.765 E.01598
G1 X102.935 Y147.998 E.11688
G1 X102.935 Y147.463 E.01598
G1 X106.237 Y150.765 E.13947
G1 X106.771 Y150.765 E.01598
G1 X102.935 Y146.929 E.16206
G1 X102.935 Y146.394 E.01598
G1 X107.306 Y150.765 E.18466
G1 X107.841 Y150.765 E.01598
G1 X102.935 Y145.859 E.20725
G1 X102.935 Y145.324 E.01598
G1 X108.376 Y150.765 E.22984
G1 X108.911 Y150.765 E.01598
G1 X102.935 Y144.789 E.25244
G1 X102.935 Y144.255 E.01598
G1 X109.445 Y150.765 E.27503
G1 X109.98 Y150.765 E.01598
G1 X102.935 Y143.72 E.29763
G1 X102.935 Y143.185 E.01598
G1 X110.515 Y150.765 E.32022
G1 X111.05 Y150.765 E.01598
G1 X102.935 Y142.65 E.34281
G1 X102.935 Y142.115 E.01598
G1 X111.585 Y150.765 E.36541
G1 X112.119 Y150.765 E.01598
G1 X102.935 Y141.581 E.388
G1 X102.935 Y141.046 E.01598
G1 X112.654 Y150.765 E.4106
G1 X113.189 Y150.765 E.01598
G1 X102.935 Y140.511 E.43319
G1 X102.935 Y139.976 E.01598
G1 X113.724 Y150.765 E.45578
G1 X114.259 Y150.765 E.01598
G1 X102.935 Y139.441 E.47838
G1 X102.935 Y138.906 E.01598
G1 X114.794 Y150.765 E.50097
G1 X115.328 Y150.765 E.01598
G1 X105.899 Y141.335 E.39836
G1 X106.434 Y141.335 E.01598
G1 X115.863 Y150.765 E.39836
G1 X116.398 Y150.765 E.01598
G1 X106.968 Y141.335 E.39836
G1 X107.503 Y141.335 E.01598
G1 X116.933 Y150.765 E.39836
G1 X117.468 Y150.765 E.01598
G1 X108.038 Y141.335 E.39836
G1 X108.573 Y141.335 E.01598
G1 X118.172 Y150.934 E.40553
; WIPE_START
G1 X116.758 Y149.52 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.215 Y141.901 Z2.2 F30000
G1 X118.915 Y113.598 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.915 Y104.802 E.28284
G1 X123.085 Y104.802 E.13411
G1 X123.085 Y113.598 E.28284
G1 X118.975 Y113.598 E.13218
M204 S250
G1 X118.523 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.523 Y104.41 E.28536
G1 X123.477 Y104.41 E.14758
G1 X123.477 Y113.99 E.28536
G1 X118.583 Y113.99 E.1458
; WIPE_START
M204 S10000
G1 X118.57 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.374 Y113.139 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F12000
G1 X119.374 Y105.321 E.31558
; WIPE_START
G1 X119.374 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.167 Y107.177 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.167 Y108.805 E.05236
G1 X119.833 Y111.139 E.10617
G1 X119.833 Y110.157 E.0316
G1 X122.167 Y112.491 E.10617
G1 X122.167 Y113.25 E.02438
G1 X121.297 Y113.25 E.02798
; WIPE_START
G1 X122.167 Y113.25 E-.3306
G1 X122.167 Y112.491 E-.28815
G1 X121.904 Y112.229 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.626 Y113.139 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.626 Y105.321 E.31557
; WIPE_START
G1 X122.626 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.862 Y114.915 Z2.2 F30000
G1 X118.915 Y144.198 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X118.915 Y135.402 E.28284
G1 X123.085 Y135.402 E.13411
G1 X123.085 Y144.198 E.28284
G1 X118.975 Y144.198 E.13218
M204 S250
G1 X118.523 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.523 Y135.01 E.28536
G1 X123.477 Y135.01 E.14758
G1 X123.477 Y144.59 E.28536
G1 X118.583 Y144.59 E.1458
; WIPE_START
M204 S10000
G1 X118.57 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.374 Y143.739 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F12000
G1 X119.374 Y135.921 E.31558
; WIPE_START
G1 X119.374 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.167 Y137.88 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.167 Y139.509 E.05236
G1 X119.833 Y141.843 E.10617
G1 X119.833 Y140.861 E.0316
G1 X122.167 Y143.195 E.10617
G1 X122.167 Y143.85 E.02105
G1 X121.194 Y143.85 E.03131
; WIPE_START
G1 X122.167 Y143.85 E-.37005
G1 X122.167 Y143.195 E-.24871
G1 X121.904 Y142.932 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.626 Y143.739 Z2.2 F30000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.626 Y135.921 E.31557
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
G1 X122.626 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 10/22
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
G17
G3 Z2.2 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X127.653 Y124.576
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X128.347 Y124.567 I.32 J-2.061 E.02244
G1 X128.347 Y128.422 E.12397
G1 X127.653 Y128.422 E.02233
G1 X127.653 Y124.636 E.12174
; WIPE_START
G1 X127.948 Y124.601 E-.11281
G1 X128.122 Y124.599 E-.06613
G1 X128.347 Y124.567 E-.0866
G1 X128.347 Y125.868 E-.49447
; WIPE_END
G1 E-.04 F1800
G1 X126.917 Y122.462 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X127.049 Y122.245 E.00758
G3 X127.822 Y121.803 I.944 J.755 E.02715
G1 X127.948 Y121.792 E.00378
G3 X126.887 Y122.513 I.045 J1.208 E.18595
; WIPE_START
M204 S10000
G1 X127.049 Y122.245 E-.11908
G1 X127.177 Y122.113 E-.06973
G1 X127.395 Y121.952 E-.10301
G1 X127.643 Y121.844 E-.10295
G1 X127.822 Y121.803 E-.06963
G1 X127.948 Y121.792 E-.04822
G1 X128.183 Y121.804 E-.08914
G1 X128.439 Y121.872 E-.10105
G1 X128.575 Y121.938 E-.05719
; WIPE_END
G1 E-.04 F1800
G1 X127.653 Y121.425 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X127.653 Y117.578 E.1237
G1 X128.347 Y117.578 E.02233
G1 X128.347 Y121.428 E.1238
G2 X127.712 Y121.417 I-.357 J2.296 E.02049
; WIPE_START
G1 X127.681 Y119.417 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.232 Y120.528 Z2.4 F30000
G1 X141.347 Y121.428 Z2.4
G1 Z2
G1 E.8 F1800
G1 F15476.087
G2 X140.653 Y121.425 I-.357 J2.296 E.02242
G1 X140.653 Y117.578 E.1237
G1 X141.347 Y117.578 E.02233
G1 X141.347 Y121.368 E.12187
; WIPE_START
G1 X140.933 Y121.399 E-.15797
G1 X140.653 Y121.425 E-.10682
G1 X140.653 Y120.121 E-.49521
; WIPE_END
G1 E-.04 F1800
G1 X142.17 Y122.733 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G3 X140.822 Y121.803 I-1.177 J.264 E.17208
G1 X140.948 Y121.792 E.00378
G3 X142.156 Y122.675 I.045 J1.205 E.04806
; WIPE_START
M204 S10000
G1 X142.207 Y122.909 E-.09132
G1 X142.203 Y123.129 E-.08342
G1 X142.156 Y123.357 E-.0883
G1 X142.09 Y123.525 E-.06873
G1 X141.946 Y123.754 E-.10297
G1 X141.755 Y123.946 E-.10296
G1 X141.605 Y124.048 E-.06878
G1 X141.354 Y124.157 E-.10383
G1 X141.226 Y124.181 E-.04969
; WIPE_END
G1 E-.04 F1800
G1 X141.347 Y124.567 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X141.347 Y128.422 E.12397
G1 X140.653 Y128.422 E.02233
G1 X140.653 Y124.576 E.12367
G2 X141.288 Y124.577 I.32 J-2.061 E.02051
; WIPE_START
G1 X141.319 Y126.577 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.305 Y123.567 Z2.4 F30000
G1 X115.29 Y115.41 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
M73 P61 R5
G1 X115.29 Y102.99 E.36995
G1 X132.71 Y102.99 E.51888
G1 X132.71 Y115.41 E.36995
G1 X115.35 Y115.41 E.5171
; WIPE_START
M204 S10000
G1 X115.34 Y113.41 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.81 Y108.39 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S5000
G1 X112.21 Y108.39 E.07149
G1 X112.21 Y110.01 E.04825
G1 X109.81 Y110.01 E.07149
G1 X109.81 Y112.41 E.07149
G1 X108.19 Y112.41 E.04825
G1 X108.19 Y110.01 E.07149
G1 X105.79 Y110.01 E.07149
G1 X105.79 Y108.39 E.04825
G1 X108.19 Y108.39 E.07149
G1 X108.19 Y105.99 E.07149
G1 X109.81 Y105.99 E.04825
G1 X109.81 Y108.33 E.0697
; WIPE_START
M204 S10000
G1 X111.809 Y108.38 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.807 Y115.746 Z2.4 F30000
G1 X115.347 Y121.428 Z2.4
G1 Z2
M73 P62 R5
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G2 X114.653 Y121.425 I-.357 J2.296 E.02242
G1 X114.653 Y117.578 E.1237
G1 X115.347 Y117.578 E.02233
G1 X115.347 Y121.368 E.12187
; WIPE_START
G1 X114.933 Y121.399 E-.15797
G1 X114.653 Y121.425 E-.10682
G1 X114.653 Y120.121 E-.49521
; WIPE_END
G1 E-.04 F1800
G1 X116.18 Y122.735 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.196 Y122.91 E.00523
G3 X114.822 Y121.803 I-1.203 J.086 E.16673
G1 X114.948 Y121.792 E.00378
G3 X116.158 Y122.685 I.045 J1.205 E.04838
; WIPE_START
M204 S10000
G1 X116.196 Y122.91 E-.08681
G1 X116.203 Y123.129 E-.08316
G1 X116.156 Y123.357 E-.08831
G1 X116.09 Y123.525 E-.06873
G1 X115.946 Y123.754 E-.10297
G1 X115.755 Y123.946 E-.10296
G1 X115.605 Y124.048 E-.06878
G1 X115.354 Y124.157 E-.10383
G1 X115.214 Y124.184 E-.05447
; WIPE_END
G1 E-.04 F1800
G1 X115.347 Y124.567 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X115.347 Y128.422 E.12397
G1 X114.653 Y128.422 E.02233
G1 X114.653 Y124.576 E.12367
G2 X115.288 Y124.577 I.32 J-2.061 E.02051
; WIPE_START
G1 X115.319 Y126.577 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.308 Y134.209 Z2.4 F30000
G1 X115.29 Y146.01 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X115.29 Y133.59 E.36995
G1 X132.71 Y133.59 E.51888
G1 X132.71 Y146.01 E.36995
G1 X115.35 Y146.01 E.5171
; WIPE_START
M204 S10000
G1 X115.34 Y144.01 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.584 Y140.459 Z2.4 F30000
G1 X105.79 Y138.99 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S5000
G1 X112.21 Y138.99 E.19123
G1 X112.21 Y140.61 E.04825
G1 X105.79 Y140.61 E.19123
G1 X105.79 Y139.05 E.04647
; WIPE_START
M204 S10000
G1 X107.79 Y139.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.187 Y140.912 Z2.4 F30000
G1 X153.509 Y150.654 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S5000
G3 X151.996 Y151.49 I-1.522 J-.966 E.05371
G1 X104.004 Y151.49 E1.42952
G3 X102.21 Y149.696 I.008 J-1.802 E.08383
G1 X102.21 Y102.303 E1.41168
G3 X104.004 Y100.51 I1.802 J.009 E.08382
G1 X152.123 Y100.515 E1.43329
G3 X153.79 Y102.303 I-.126 J1.789 E.08016
G1 X153.79 Y149.696 E1.41168
G3 X153.541 Y150.603 I-1.802 J-.009 E.02832
M204 S10000
G1 X152.87 Y151.033 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276528
G1 F15000
G1 X152.418 Y151.107 E.00846
; LINE_WIDTH: 0.319266
G3 X152.202 Y151.13 I-.415 J-2.85 E.00475
; LINE_WIDTH: 0.355066
G3 X151.989 Y151.138 I-.208 J-2.938 E.00524
G1 X139.882 Y151.138 E.29854
; WIPE_START
G1 X141.882 Y151.138 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.249 Y151.138 Z2.4 F30000
G1 X132.118 Y151.138 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.35516
G1 F15000
G1 X123.882 Y151.138 E.20315
; WIPE_START
G1 X125.882 Y151.138 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.249 Y151.138 Z2.4 F30000
G1 X116.118 Y151.138 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.354865
G1 F15000
G1 X104.011 Y151.138 E.29835
G3 X103.693 Y151.121 I.013 J-3.284 E.00783
; LINE_WIDTH: 0.307832
G1 X103.581 Y151.107 E.00237
; LINE_WIDTH: 0.276425
G1 X103.13 Y151.033 E.00843
; WIPE_START
G1 X103.581 Y151.107 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.206 Y143.484 Z2.4 F30000
G1 X102.475 Y128.618 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.18016
G1 F15000
G1 X102.475 Y117.382 E.12182
; WIPE_START
G1 X102.475 Y119.382 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.046 Y118.414 Z2.4 F30000
G1 X115 Y117.781 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.33031
G1 F15000
G1 X115 Y121.196 E.07753
; WIPE_START
G1 X115 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y124.804 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F15000
G1 X115 Y128.219 E.07752
; WIPE_START
G1 X115 Y126.219 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.544 Y127.379 Z2.4 F30000
G1 X128 Y128.219 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.33032
G1 F15000
G1 X128 Y124.804 E.07752
; WIPE_START
G1 X128 Y126.804 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y121.196 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F15000
G1 X128 Y117.781 E.07753
; WIPE_START
G1 X128 Y119.781 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.544 Y118.621 Z2.4 F30000
G1 X141 Y117.781 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.33031
G1 F15000
G1 X141 Y121.196 E.07753
; WIPE_START
G1 X141 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141 Y124.804 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F15000
G1 X141 Y128.219 E.07752
; WIPE_START
G1 X141 Y126.219 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X148.496 Y127.655 Z2.4 F30000
G1 X153.525 Y128.618 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.18016
G1 F15000
G1 X153.525 Y117.382 E.12182
; WIPE_START
G1 X153.525 Y119.382 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X153.255 Y111.754 Z2.4 F30000
G1 X152.874 Y100.967 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.277511
G1 F15000
G1 X152.418 Y100.893 E.00855
; LINE_WIDTH: 0.318673
G2 X152.209 Y100.87 I-.421 J2.895 E.00458
; LINE_WIDTH: 0.355086
G2 X151.989 Y100.862 I-.222 J3.172 E.00542
G1 X134.882 Y100.862 E.42186
; WIPE_START
G1 X136.882 Y100.862 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.249 Y100.862 Z2.4 F30000
G1 X121.118 Y100.862 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.354935
G1 F15000
G1 X104.011 Y100.862 E.42165
G2 X103.686 Y100.879 I.013 J3.296 E.008
; LINE_WIDTH: 0.307289
G1 X103.582 Y100.893 E.0022
; LINE_WIDTH: 0.276525
G1 X103.13 Y100.967 E.00846
; WIPE_START
G1 X103.582 Y100.893 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.909 Y106.359 Z2.4 F30000
G1 X152.371 Y150.955 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F12000
M204 S2000
G1 X153.581 Y149.745 E.05097
G1 X153.583 Y149.21
G1 X151.838 Y150.955 E.0735
G1 X151.304 Y150.955
G1 X153.583 Y148.677 E.09597
G1 X153.583 Y148.144
G1 X150.771 Y150.955 E.11843
G1 X150.238 Y150.955
G1 X153.583 Y147.611 E.14089
G1 X153.583 Y147.077
G1 X149.705 Y150.955 E.16336
G1 X149.171 Y150.955
G1 X153.583 Y146.544 E.18582
G1 X153.583 Y146.011
G1 X148.638 Y150.955 E.20828
G1 X148.105 Y150.955
G1 X153.583 Y145.478 E.23075
G1 X153.583 Y144.944
G1 X147.572 Y150.955 E.25321
G1 X147.038 Y150.955
G1 X153.583 Y144.411 E.27567
G1 X153.583 Y143.878
G1 X146.505 Y150.955 E.29814
G1 X145.972 Y150.955
G1 X153.583 Y143.345 E.3206
G1 X153.583 Y142.811
G1 X145.439 Y150.955 E.34306
G1 X144.905 Y150.955
G1 X153.583 Y142.278 E.36553
G1 X153.583 Y141.745
G1 X144.372 Y150.955 E.38799
G1 X143.839 Y150.955
G1 X153.583 Y141.212 E.41045
G1 X153.583 Y140.678
G1 X143.306 Y150.955 E.43292
G1 X142.772 Y150.955
G1 X153.583 Y140.145 E.45538
G1 X153.583 Y139.612
G1 X142.239 Y150.955 E.47784
G1 X141.706 Y150.955
G1 X153.583 Y139.078 E.5003
M73 P63 R5
G1 X153.583 Y138.545
G1 X141.173 Y150.955 E.52277
G1 X140.639 Y150.955
G1 X153.583 Y138.012 E.54523
G1 X153.583 Y137.479
G1 X140.106 Y150.955 E.56769
G1 X139.245 Y151.283
G1 X153.583 Y136.945 E.60395
G1 X153.583 Y136.412
G1 X138.712 Y151.283 E.62641
G1 X138.179 Y151.283
G1 X153.583 Y135.879 E.64887
G1 X153.583 Y135.346
G1 X137.646 Y151.283 E.67134
G1 X137.112 Y151.283
G1 X153.583 Y134.812 E.6938
G1 X153.583 Y134.279
G1 X136.579 Y151.283 E.71626
G1 X136.046 Y151.283
G1 X153.583 Y133.746 E.73873
G1 X153.583 Y133.213
G1 X135.513 Y151.283 E.76119
G1 X134.979 Y151.283
G1 X153.583 Y132.679 E.78365
G1 X153.583 Y132.146
G1 X134.446 Y151.283 E.80612
G1 X133.913 Y151.283
G1 X153.583 Y131.613 E.82858
G1 X153.583 Y131.08
G1 X133.38 Y151.283 E.85104
G1 X132.846 Y151.283
G1 X153.583 Y130.546 E.87351
G1 X153.583 Y130.013
G1 X132.313 Y151.283 E.89597
G1 X132.107 Y150.955
G1 X153.583 Y129.48 E.90464
G1 X153.583 Y128.947
G1 X131.574 Y150.955 E.92711
G1 X131.041 Y150.955
G1 X153.43 Y128.566 E.94315
G1 X153.43 Y128.032
G1 X130.507 Y150.955 E.96562
G1 X129.974 Y150.955
G1 X153.43 Y127.499 E.98808
G1 X153.43 Y126.966
G1 X129.441 Y150.955 E1.01054
G1 X128.908 Y150.955
G1 X153.43 Y126.433 E1.03301
G1 X153.43 Y125.899
G1 X128.374 Y150.955 E1.05547
G1 X127.841 Y150.955
G1 X132.579 Y146.217 E.19958
G1 X132.046 Y146.217
G1 X127.308 Y150.955 E.19958
G1 X126.775 Y150.955
G1 X131.512 Y146.217 E.19958
G1 X130.979 Y146.217
G1 X126.241 Y150.955 E.19958
G1 X125.708 Y150.955
G1 X130.446 Y146.217 E.19958
G1 X129.913 Y146.217
G1 X125.175 Y150.955 E.19958
G1 X124.642 Y150.955
G1 X129.379 Y146.217 E.19958
G1 X128.846 Y146.217
G1 X124.108 Y150.955 E.19958
G1 X123.248 Y151.283
G1 X128.313 Y146.217 E.21337
G1 X127.78 Y146.217
G1 X122.714 Y151.283 E.21337
G1 X122.181 Y151.283
G1 X127.246 Y146.217 E.21337
G1 X126.713 Y146.217
G1 X121.648 Y151.283 E.21337
G1 X121.115 Y151.283
G1 X126.18 Y146.217 E.21337
G1 X125.647 Y146.217
G1 X120.581 Y151.283 E.21337
G1 X120.048 Y151.283
G1 X125.113 Y146.217 E.21337
G1 X124.58 Y146.217
G1 X119.515 Y151.283 E.21337
G1 X118.982 Y151.283
G1 X124.047 Y146.217 E.21337
G1 X123.514 Y146.217
G1 X118.448 Y151.283 E.21337
G1 X117.915 Y151.283
G1 X122.98 Y146.217 E.21337
G1 X122.447 Y146.217
G1 X117.382 Y151.283 E.21337
G1 X116.849 Y151.283
G1 X121.914 Y146.217 E.21337
G1 X121.381 Y146.217
G1 X116.315 Y151.283 E.21337
G1 X116.109 Y150.955
G1 X120.847 Y146.217 E.19958
M73 P64 R5
G1 X120.314 Y146.217
G1 X115.576 Y150.955 E.19958
G1 X115.043 Y150.955
G1 X119.781 Y146.217 E.19958
G1 X119.248 Y146.217
G1 X114.51 Y150.955 E.19958
G1 X113.976 Y150.955
G1 X118.714 Y146.217 E.19958
G1 X118.181 Y146.217
G1 X113.443 Y150.955 E.19958
G1 X112.91 Y150.955
G1 X117.648 Y146.217 E.19958
G1 X117.115 Y146.217
G1 X112.377 Y150.955 E.19958
G1 X111.843 Y150.955
G1 X116.581 Y146.217 E.19958
G1 X116.048 Y146.217
G1 X111.31 Y150.955 E.19958
G1 X110.777 Y150.955
G1 X115.515 Y146.217 E.19958
G1 X115.083 Y146.116
G1 X110.244 Y150.955 E.20384
G1 X109.71 Y150.955
G1 X115.083 Y145.583 E.2263
G1 X115.083 Y145.05
G1 X109.177 Y150.955 E.24877
G1 X108.644 Y150.955
G1 X115.083 Y144.517 E.27123
G1 X115.083 Y143.983
G1 X108.111 Y150.955 E.29369
G1 X107.577 Y150.955
G1 X115.083 Y143.45 E.31616
G1 X115.083 Y142.917
G1 X107.044 Y150.955 E.33862
G1 X106.511 Y150.955
G1 X115.083 Y142.383 E.36108
G1 X115.083 Y141.85
G1 X105.978 Y150.955 E.38355
G1 X105.444 Y150.955
G1 X115.083 Y141.317 E.40601
G1 X115.083 Y140.784
G1 X104.911 Y150.955 E.42847
G1 X104.378 Y150.955
G1 X115.083 Y140.25 E.45094
G1 X115.083 Y139.717
G1 X103.845 Y150.955 E.4734
G1 X103.311 Y150.955
G1 X115.083 Y139.184 E.49586
G1 X115.083 Y138.651
G1 X102.898 Y150.835 E.51325
G1 X102.66 Y150.54
G1 X112.383 Y140.817 E.40958
G1 X111.849 Y140.817
G1 X102.492 Y150.175 E.39419
G1 X102.418 Y149.715
G1 X111.316 Y140.817 E.37483
G1 X110.783 Y140.817
G1 X102.417 Y149.183 E.35239
G1 X102.417 Y148.65
G1 X110.25 Y140.817 E.32993
G1 X109.716 Y140.817
G1 X102.417 Y148.116 E.30747
G1 X102.417 Y147.583
G1 X109.183 Y140.817 E.285
G1 X108.65 Y140.817
G1 X102.417 Y147.05 E.26254
G1 X102.417 Y146.517
G1 X108.117 Y140.817 E.24008
G1 X107.583 Y140.817
G1 X102.417 Y145.983 E.21761
G1 X102.417 Y145.45
G1 X107.05 Y140.817 E.19515
G1 X106.517 Y140.817
G1 X102.417 Y144.917 E.17269
G1 X102.417 Y144.384
G1 X105.984 Y140.817 E.15022
G1 X105.583 Y140.685
G1 X102.417 Y143.85 E.13333
G1 X102.417 Y143.317
G1 X105.583 Y140.152 E.13333
G1 X105.583 Y139.619
G1 X102.417 Y142.784 E.13333
G1 X102.417 Y142.251
G1 X105.583 Y139.085 E.13333
; WIPE_START
M204 S10000
G1 X104.168 Y140.5 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.796 Y140.761 Z2.4 F30000
G1 X112.417 Y140.783 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X115.083 Y138.117 E.11227
G1 X115.083 Y137.584
G1 X112.417 Y140.249 E.11227
G1 X112.417 Y139.716
G1 X115.083 Y137.051 E.11227
G1 X115.083 Y136.518
G1 X112.417 Y139.183 E.11227
G1 X112.284 Y138.783
G1 X115.083 Y135.984 E.11787
G1 X115.083 Y135.451
G1 X111.751 Y138.783 E.14034
G1 X111.218 Y138.783
G1 X115.083 Y134.918 E.1628
G1 X115.083 Y134.385
G1 X110.685 Y138.783 E.18526
G1 X110.151 Y138.783
G1 X115.083 Y133.851 E.20773
; WIPE_START
M204 S10000
G1 X113.668 Y135.266 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.352 Y138.951 Z2.4 F30000
G1 X132.917 Y145.879 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X153.43 Y125.366 E.8641
G1 X153.43 Y124.833
G1 X132.917 Y145.346 E.8641
G1 X132.917 Y144.812
G1 X153.43 Y124.3 E.8641
G1 X153.43 Y123.766
G1 X132.917 Y144.279 E.8641
G1 X132.917 Y143.746
G1 X153.43 Y123.233 E.8641
G1 X153.43 Y122.7
G1 X132.917 Y143.213 E.8641
G1 X132.917 Y142.679
G1 X153.43 Y122.167 E.8641
M73 P65 R5
G1 X153.43 Y121.633
G1 X132.917 Y142.146 E.8641
G1 X132.917 Y141.613
G1 X153.43 Y121.1 E.8641
G1 X153.43 Y120.567
G1 X132.917 Y141.08 E.8641
G1 X132.917 Y140.546
G1 X153.43 Y120.034 E.8641
G1 X153.43 Y119.5
G1 X132.917 Y140.013 E.8641
G1 X132.917 Y139.48
G1 X153.43 Y118.967 E.8641
G1 X153.43 Y118.434
G1 X132.917 Y138.947 E.8641
G1 X132.917 Y138.413
G1 X153.43 Y117.901 E.8641
G1 X153.43 Y117.367
G1 X132.917 Y137.88 E.8641
G1 X132.917 Y137.347
G1 X153.583 Y116.682 E.87051
G1 X153.583 Y116.148
G1 X141.618 Y128.113 E.50401
G1 X141.618 Y127.58
G1 X153.583 Y115.615 E.50401
G1 X153.583 Y115.082
G1 X141.618 Y127.047 E.50401
G1 X141.618 Y126.513
G1 X153.583 Y114.549 E.50401
G1 X153.583 Y114.015
G1 X141.618 Y125.98 E.50401
G1 X141.618 Y125.447
G1 X153.583 Y113.482 E.50401
G1 X153.583 Y112.949
G1 X141.618 Y124.914 E.50401
G1 X142.072 Y123.927
G1 X153.583 Y112.416 E.48489
G1 X153.583 Y111.882
G1 X142.415 Y123.05 E.47043
G1 X142.353 Y122.578
G1 X153.583 Y111.349 E.47303
G1 X153.583 Y110.816
G1 X142.181 Y122.217 E.48028
G1 X141.932 Y121.934
G1 X153.583 Y110.283 E.49079
G1 X153.583 Y109.749
G1 X141.611 Y121.721 E.50429
G1 X141.618 Y121.181
G1 X153.583 Y109.216 E.50401
G1 X153.583 Y108.683
G1 X141.618 Y120.648 E.50401
G1 X141.618 Y120.114
G1 X153.583 Y108.15 E.50401
G1 X153.583 Y107.616
G1 X141.618 Y119.581 E.50401
G1 X141.618 Y119.048
G1 X153.583 Y107.083 E.50401
G1 X153.583 Y106.55
G1 X141.618 Y118.515 E.50401
G1 X141.618 Y117.981
G1 X153.583 Y106.017 E.50401
G1 X153.583 Y105.483
G1 X141.618 Y117.448 E.50401
G1 X141.225 Y117.307
G1 X153.583 Y104.95 E.52054
G1 X153.583 Y104.417
G1 X140.692 Y117.307 E.54301
; WIPE_START
M204 S10000
G1 X142.106 Y115.893 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.472 Y123.499 Z2.4 F30000
G1 X141.038 Y128.693 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X132.917 Y136.814 E.34209
G1 X132.917 Y136.28
G1 X140.505 Y128.693 E.31962
G1 X140.382 Y128.282
G1 X132.917 Y135.747 E.31445
G1 X132.917 Y135.214
G1 X140.382 Y127.749 E.31445
G1 X140.382 Y127.216
G1 X132.917 Y134.681 E.31445
G1 X132.917 Y134.147
G1 X140.382 Y126.683 E.31445
G1 X140.382 Y126.149
G1 X132.917 Y133.614 E.31445
G1 X132.616 Y133.383
G1 X140.382 Y125.616 E.32717
G1 X140.382 Y125.083
G1 X132.082 Y133.383 E.34963
G1 X131.549 Y133.383
G1 X140.43 Y124.501 E.37412
G1 X140.217 Y124.181
G1 X131.016 Y133.383 E.3876
G1 X130.483 Y133.383
G1 X139.933 Y123.932 E.3981
M73 P66 R5
G1 X139.721 Y123.611
G1 X129.949 Y133.383 E.41162
G1 X129.416 Y133.383
G1 X139.597 Y123.202 E.42887
G1 X139.631 Y122.634
G1 X128.883 Y133.383 E.45278
G1 X128.35 Y133.383
G1 X140.424 Y121.309 E.50861
G1 X140.382 Y120.817
G1 X127.816 Y133.383 E.52934
G1 X127.283 Y133.383
G1 X140.382 Y120.283 E.5518
G1 X140.382 Y119.75
G1 X126.75 Y133.383 E.57426
G1 X126.217 Y133.383
G1 X140.382 Y119.217 E.59672
G1 X140.382 Y118.684
G1 X125.683 Y133.383 E.61919
G1 X125.15 Y133.383
G1 X140.382 Y118.15 E.64165
G1 X140.382 Y117.617
G1 X124.617 Y133.383 E.66411
G1 X124.083 Y133.383
G1 X153.583 Y103.883 E1.24264
G1 X153.583 Y103.35
G1 X128.618 Y128.315 E1.05163
G1 X128.618 Y127.782
G1 X153.583 Y102.817 E1.05163
G1 X153.582 Y102.284
G1 X128.618 Y127.249 E1.0516
G1 X128.618 Y126.715
G1 X153.508 Y101.825 E1.0485
G1 X153.34 Y101.459
G1 X128.618 Y126.182 E1.04143
G1 X128.618 Y125.649
G1 X153.101 Y101.165 E1.03136
G1 X152.689 Y101.045
G1 X128.618 Y125.116 E1.01397
G1 X128.57 Y124.63
G1 X152.155 Y101.045 E.99353
G1 X151.622 Y101.045
G1 X129.389 Y123.278 E.93657
G1 X129.393 Y122.741
G1 X151.089 Y101.045 E.91394
G1 X150.556 Y101.045
G1 X129.256 Y122.344 E.89724
G1 X129.034 Y122.033
G1 X150.022 Y101.045 E.88414
G1 X149.489 Y101.045
G1 X128.741 Y121.793 E.87401
G1 X128.57 Y121.431
G1 X148.956 Y101.045 E.85875
G1 X148.423 Y101.045
G1 X128.618 Y120.849 E.83427
G1 X128.618 Y120.316
G1 X147.889 Y101.045 E.8118
G1 X147.356 Y101.045
G1 X132.917 Y115.483 E.60822
G1 X132.917 Y114.95
G1 X146.823 Y101.045 E.58576
G1 X146.289 Y101.045
G1 X132.917 Y114.417 E.56329
G1 X132.917 Y113.884
G1 X145.756 Y101.045 E.54083
G1 X145.223 Y101.045
G1 X132.917 Y113.35 E.51837
G1 X132.917 Y112.817
G1 X144.69 Y101.045 E.4959
G1 X144.156 Y101.045
G1 X132.917 Y112.284 E.47344
G1 X132.917 Y111.751
G1 X143.623 Y101.045 E.45098
G1 X143.09 Y101.045
G1 X132.917 Y111.217 E.42852
G1 X132.917 Y110.684
G1 X142.557 Y101.045 E.40605
G1 X142.023 Y101.045
G1 X132.917 Y110.151 E.38359
G1 X132.917 Y109.618
G1 X141.49 Y101.045 E.36113
M73 P67 R5
G1 X140.957 Y101.045
G1 X132.917 Y109.084 E.33866
G1 X132.917 Y108.551
G1 X140.424 Y101.045 E.3162
G1 X139.89 Y101.045
G1 X132.917 Y108.018 E.29374
G1 X132.917 Y107.484
G1 X139.357 Y101.045 E.27127
G1 X138.824 Y101.045
G1 X132.917 Y106.951 E.24881
G1 X132.917 Y106.418
G1 X138.291 Y101.045 E.22635
G1 X137.757 Y101.045
G1 X132.917 Y105.885 E.20388
G1 X132.917 Y105.351
G1 X137.224 Y101.045 E.18142
G1 X136.691 Y101.045
G1 X132.917 Y104.818 E.15896
G1 X132.917 Y104.285
G1 X136.158 Y101.045 E.13649
G1 X135.624 Y101.045
G1 X132.917 Y103.752 E.11403
G1 X132.917 Y103.218
G1 X135.091 Y101.045 E.09157
G1 X134.855 Y100.747
G1 X132.82 Y102.783 E.08574
G1 X132.287 Y102.783
G1 X134.352 Y100.717 E.087
G1 X133.819 Y100.717
G1 X131.753 Y102.783 E.087
G1 X131.22 Y102.783
G1 X133.285 Y100.717 E.087
G1 X132.752 Y100.717
G1 X130.687 Y102.783 E.087
G1 X130.154 Y102.783
G1 X132.219 Y100.717 E.087
G1 X131.686 Y100.717
G1 X129.62 Y102.783 E.087
G1 X129.087 Y102.783
G1 X131.152 Y100.717 E.087
G1 X130.619 Y100.717
G1 X128.554 Y102.783 E.087
G1 X128.021 Y102.783
G1 X130.086 Y100.717 E.087
G1 X129.553 Y100.717
G1 X127.487 Y102.783 E.087
G1 X126.954 Y102.783
G1 X129.019 Y100.717 E.087
G1 X128.486 Y100.717
G1 X126.421 Y102.783 E.087
G1 X125.888 Y102.783
G1 X127.953 Y100.717 E.087
G1 X127.42 Y100.717
G1 X125.354 Y102.783 E.087
G1 X124.821 Y102.783
G1 X126.886 Y100.717 E.087
G1 X126.353 Y100.717
G1 X124.288 Y102.783 E.087
G1 X123.755 Y102.783
G1 X125.82 Y100.717 E.087
G1 X125.287 Y100.717
G1 X123.221 Y102.783 E.087
G1 X122.688 Y102.783
G1 X124.753 Y100.717 E.087
G1 X124.22 Y100.717
G1 X122.155 Y102.783 E.087
G1 X121.622 Y102.783
G1 X123.687 Y100.717 E.087
G1 X123.154 Y100.717
G1 X121.088 Y102.783 E.087
G1 X120.555 Y102.783
G1 X122.62 Y100.717 E.087
G1 X122.087 Y100.717
G1 X120.022 Y102.783 E.087
G1 X119.489 Y102.783
G1 X121.554 Y100.717 E.087
G1 X120.693 Y101.045
G1 X118.955 Y102.783 E.07321
G1 X118.422 Y102.783
G1 X120.16 Y101.045 E.07321
G1 X119.627 Y101.045
G1 X117.889 Y102.783 E.07321
G1 X117.355 Y102.783
G1 X119.093 Y101.045 E.07321
G1 X118.56 Y101.045
G1 X116.822 Y102.783 E.07321
G1 X116.289 Y102.783
G1 X118.027 Y101.045 E.07321
G1 X117.494 Y101.045
G1 X115.756 Y102.783 E.07321
G1 X115.222 Y102.783
G1 X116.96 Y101.045 E.07321
; WIPE_START
M204 S10000
G1 X115.546 Y102.459 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.139 Y106.607 Z2.4 F30000
G1 X107.983 Y107.356 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X107.156 Y108.183 E.03481
G1 X106.623 Y108.183
G1 X107.983 Y106.823 E.05728
G1 X107.983 Y106.29
G1 X106.09 Y108.183 E.07974
; WIPE_START
M204 S10000
G1 X107.504 Y106.768 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.001 Y110.773 Z2.4 F30000
G1 X128.618 Y119.783 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X132.783 Y115.617 E.17547
G1 X132.25 Y115.617
G1 X128.618 Y119.25 E.15301
G1 X128.618 Y118.716
G1 X131.717 Y115.617 E.13055
G1 X131.184 Y115.617
G1 X128.618 Y118.183 E.10808
G1 X128.618 Y117.65
G1 X130.65 Y115.617 E.08562
G1 X130.117 Y115.617
G1 X128.427 Y117.307 E.07118
G1 X127.894 Y117.307
G1 X129.584 Y115.617 E.07118
; WIPE_START
M204 S10000
G1 X128.17 Y117.032 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.216 Y124.664 Z2.4 F30000
G1 X128.24 Y128.693 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X123.55 Y133.383 E.19756
G1 X123.017 Y133.383
G1 X127.707 Y128.693 E.19756
G1 X127.382 Y128.484
G1 X122.484 Y133.383 E.20635
G1 X121.95 Y133.383
G1 X127.382 Y127.951 E.22881
G1 X127.382 Y127.418
G1 X121.417 Y133.383 E.25127
G1 X120.884 Y133.383
G1 X127.382 Y126.884 E.27374
G1 X127.382 Y126.351
G1 X120.351 Y133.383 E.2962
G1 X119.817 Y133.383
G1 X127.382 Y125.818 E.31866
G1 X127.382 Y125.285
G1 X119.284 Y133.383 E.34113
G1 X118.751 Y133.383
G1 X127.409 Y124.724 E.36473
G1 X127.344 Y124.256
G1 X118.218 Y133.383 E.38446
G1 X117.684 Y133.383
G1 X127.031 Y124.036 E.39374
G1 X126.793 Y123.741
G1 X117.151 Y133.383 E.40614
G1 X116.618 Y133.383
G1 X126.632 Y123.368 E.42184
G1 X126.59 Y122.878
G1 X116.085 Y133.383 E.44252
G1 X115.551 Y133.383
G1 X127.43 Y121.504 E.50039
G1 X127.382 Y121.019
G1 X109.618 Y138.783 E.74831
G1 X109.085 Y138.783
G1 X127.382 Y120.485 E.77077
G1 X127.382 Y119.952
G1 X108.552 Y138.783 E.79323
M73 P68 R5
G1 X108.018 Y138.783
G1 X127.382 Y119.419 E.8157
G1 X127.382 Y118.885
G1 X107.485 Y138.783 E.83816
G1 X106.952 Y138.783
G1 X127.382 Y118.352 E.86062
G1 X127.382 Y117.819
G1 X106.419 Y138.783 E.88309
G1 X105.885 Y138.783
G1 X129.051 Y115.617 E.97583
G1 X128.517 Y115.617
G1 X115.618 Y128.517 E.54339
G1 X115.618 Y127.984
G1 X127.984 Y115.617 E.52092
G1 X127.451 Y115.617
G1 X115.618 Y127.45 E.49846
G1 X115.618 Y126.917
G1 X126.918 Y115.617 E.476
G1 X126.384 Y115.617
M73 P68 R4
G1 X115.618 Y126.384 E.45353
G1 X115.618 Y125.851
G1 X125.851 Y115.617 E.43107
G1 X125.318 Y115.617
G1 X115.618 Y125.317 E.40861
G1 X115.618 Y124.784
G1 X124.784 Y115.617 E.38614
G1 X124.251 Y115.617
G1 X116.296 Y123.573 E.33512
G1 X116.415 Y122.921
G1 X123.718 Y115.617 E.30765
G1 X123.185 Y115.617
G1 X116.32 Y122.482 E.28918
G1 X116.126 Y122.142
G1 X122.651 Y115.617 E.27487
G1 X122.118 Y115.617
G1 X115.86 Y121.875 E.26361
G1 X115.57 Y121.633
G1 X121.585 Y115.617 E.25339
G1 X121.052 Y115.617
G1 X115.618 Y121.051 E.2289
G1 X115.618 Y120.518
G1 X120.518 Y115.617 E.20644
G1 X119.985 Y115.617
G1 X115.618 Y119.985 E.18397
G1 X115.618 Y119.452
G1 X119.452 Y115.617 E.16151
G1 X118.919 Y115.617
G1 X115.618 Y118.918 E.13905
G1 X115.618 Y118.385
G1 X118.385 Y115.617 E.11658
G1 X117.852 Y115.617
G1 X115.618 Y117.852 E.09412
G1 X115.572 Y117.365
G1 X117.319 Y115.617 E.07361
G1 X116.786 Y115.617
G1 X115.096 Y117.307 E.07118
G1 X114.563 Y117.307
G1 X116.252 Y115.617 E.07118
; WIPE_START
M204 S10000
G1 X114.838 Y117.032 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.233 Y124.654 Z2.4 F30000
G1 X115.442 Y128.693 Z2.4
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X102.417 Y141.717 E.54865
G1 X102.417 Y141.184
G1 X114.909 Y128.693 E.52619
G1 X114.431 Y128.637
G1 X102.417 Y140.651 E.50606
G1 X102.417 Y140.118
G1 X114.382 Y128.153 E.50401
G1 X114.382 Y127.619
G1 X102.417 Y139.584 E.50401
G1 X102.417 Y139.051
G1 X114.382 Y127.086 E.50401
G1 X114.382 Y126.553
G1 X102.417 Y138.518 E.50401
G1 X102.417 Y137.984
G1 X114.382 Y126.02 E.50401
G1 X114.382 Y125.486
G1 X102.417 Y137.451 E.50401
G1 X102.417 Y136.918
G1 X114.382 Y124.953 E.50401
G1 X114.43 Y124.372
G1 X102.417 Y136.385 E.50604
G1 X102.417 Y135.851
G1 X114.142 Y124.127 E.49388
G1 X113.875 Y123.861
G1 X102.417 Y135.318 E.48263
G1 X102.417 Y134.785
G1 X113.682 Y123.521 E.4745
G1 X113.585 Y123.084
G1 X102.417 Y134.252 E.47045
G1 X102.417 Y133.718
G1 X113.701 Y122.435 E.47531
; WIPE_START
M204 S10000
G1 X112.287 Y123.849 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.382 Y121.22 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X102.417 Y133.185 E.50401
G1 X102.417 Y132.652
G1 X114.382 Y120.687 E.50401
G1 X114.382 Y120.154
G1 X102.417 Y132.119 E.50401
G1 X102.417 Y131.585
G1 X114.382 Y119.621 E.50401
G1 X114.382 Y119.087
G1 X102.417 Y131.052 E.50401
M73 P69 R4
G1 X102.417 Y130.519
G1 X114.382 Y118.554 E.50401
G1 X114.382 Y118.021
G1 X102.417 Y129.986 E.50401
G1 X102.417 Y129.452
G1 X114.382 Y117.488 E.50401
; WIPE_START
M204 S10000
G1 X112.968 Y118.902 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.719 Y115.617 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X102.417 Y128.919 E.56033
G1 X102.57 Y128.234
G1 X115.186 Y115.617 E.53145
G1 X115.083 Y115.187
G1 X102.57 Y127.7 E.5271
G1 X102.57 Y127.167
G1 X115.083 Y114.654 E.5271
G1 X115.083 Y114.121
G1 X102.57 Y126.634 E.5271
G1 X102.57 Y126.1
G1 X115.083 Y113.588 E.5271
G1 X115.083 Y113.054
G1 X102.57 Y125.567 E.5271
G1 X102.57 Y125.034
G1 X115.083 Y112.521 E.5271
G1 X115.083 Y111.988
G1 X102.57 Y124.501 E.5271
G1 X102.57 Y123.967
G1 X115.083 Y111.455 E.5271
G1 X115.083 Y110.921
G1 X102.57 Y123.434 E.5271
G1 X102.57 Y122.901
G1 X115.083 Y110.388 E.5271
G1 X115.083 Y109.855
G1 X102.57 Y122.368 E.5271
G1 X102.57 Y121.834
G1 X115.083 Y109.322 E.5271
G1 X115.083 Y108.788
G1 X102.57 Y121.301 E.5271
G1 X102.57 Y120.768
G1 X115.083 Y108.255 E.5271
G1 X115.083 Y107.722
G1 X102.57 Y120.235 E.5271
G1 X102.57 Y119.701
G1 X109.654 Y112.617 E.29841
G1 X109.12 Y112.617
G1 X102.57 Y119.168 E.27595
G1 X102.57 Y118.635
G1 X108.587 Y112.617 E.25348
G1 X108.054 Y112.617
G1 X102.57 Y118.102 E.23102
G1 X102.57 Y117.568
G1 X107.983 Y112.155 E.22802
G1 X107.983 Y111.622
G1 X102.417 Y117.187 E.23443
G1 X102.417 Y116.654
G1 X107.983 Y111.089 E.23443
G1 X107.983 Y110.556
G1 X102.417 Y116.121 E.23443
G1 X102.417 Y115.588
G1 X107.788 Y110.217 E.22622
G1 X107.254 Y110.217
G1 X102.417 Y115.054 E.20376
G1 X102.417 Y114.521
G1 X106.721 Y110.217 E.18129
G1 X106.188 Y110.217
G1 X102.417 Y113.988 E.15883
G1 X102.417 Y113.455
G1 X105.655 Y110.217 E.13637
G1 X105.583 Y109.756
G1 X102.417 Y112.921 E.13333
G1 X102.417 Y112.388
G1 X105.583 Y109.223 E.13333
G1 X105.583 Y108.69
G1 X102.417 Y111.855 E.13333
; WIPE_START
M204 S10000
G1 X103.832 Y110.441 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.017 Y112.254 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X112.054 Y110.217 E.08578
G1 X111.52 Y110.217
G1 X110.017 Y111.72 E.06332
G1 X110.017 Y111.187
G1 X110.987 Y110.217 E.04085
G1 X110.454 Y110.217
G1 X110.017 Y110.654 E.01839
; WIPE_START
M204 S10000
G1 X110.454 Y110.217 E-.23462
G1 X110.987 Y110.217 E-.20264
G1 X110.387 Y110.818 E-.32274
; WIPE_END
G1 E-.04 F1800
G1 X112.417 Y109.854 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X115.083 Y107.188 E.11227
G1 X115.083 Y106.655
G1 X112.417 Y109.32 E.11227
G1 X112.417 Y108.787
G1 X115.083 Y106.122 E.11227
G1 X115.083 Y105.589
G1 X112.417 Y108.254 E.11227
G1 X111.955 Y108.183
G1 X115.083 Y105.055 E.13173
G1 X115.083 Y104.522
G1 X111.422 Y108.183 E.15419
G1 X110.889 Y108.183
G1 X115.083 Y103.989 E.17666
G1 X115.083 Y103.456
G1 X110.356 Y108.183 E.19912
G1 X110.017 Y107.988
G1 X115.083 Y102.922 E.21337
; WIPE_START
M204 S10000
G1 X113.668 Y104.337 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.427 Y101.045 Z2.4 F30000
G1 Z2
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X110.017 Y107.454 E.27001
G1 X110.017 Y106.921
G1 X115.894 Y101.045 E.24754
G1 X115.361 Y101.045
G1 X110.017 Y106.388 E.22508
G1 X110.017 Y105.855
G1 X114.827 Y101.045 E.20262
G1 X114.294 Y101.045
G1 X109.556 Y105.783 E.19958
G1 X109.023 Y105.783
G1 X113.761 Y101.045 E.19958
G1 X113.228 Y101.045
G1 X108.49 Y105.783 E.19958
; WIPE_START
M204 S10000
G1 X109.904 Y104.368 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.694 Y101.045 Z2.4 F30000
G1 Z2
G1 E.8 F1800
M73 P70 R4
G1 F12000
M204 S2000
G1 X102.417 Y111.322 E.43291
G1 X102.417 Y110.788
G1 X112.161 Y101.045 E.41045
G1 X111.628 Y101.045
G1 X102.417 Y110.255 E.38798
G1 X102.417 Y109.722
G1 X111.094 Y101.045 E.36552
G1 X110.561 Y101.045
G1 X102.417 Y109.189 E.34306
G1 X102.417 Y108.655
G1 X110.028 Y101.045 E.32059
G1 X109.495 Y101.045
G1 X102.417 Y108.122 E.29813
G1 X102.417 Y107.589
G1 X108.961 Y101.045 E.27567
G1 X108.428 Y101.045
G1 X102.417 Y107.056 E.2532
G1 X102.417 Y106.522
G1 X107.895 Y101.045 E.23074
G1 X107.362 Y101.045
G1 X102.417 Y105.989 E.20828
G1 X102.417 Y105.456
G1 X106.828 Y101.045 E.18581
G1 X106.295 Y101.045
G1 X102.417 Y104.923 E.16335
G1 X102.417 Y104.389
G1 X105.762 Y101.045 E.14089
G1 X105.229 Y101.045
G1 X102.417 Y103.856 E.11842
G1 X102.417 Y103.323
G1 X104.695 Y101.045 E.09596
G1 X104.162 Y101.045
G1 X102.417 Y102.789 E.0735
G1 X102.419 Y102.254
G1 X103.629 Y101.045 E.05096
; WIPE_START
M204 S10000
G1 X102.419 Y102.254 E-.65012
G1 X102.418 Y102.544 E-.10989
; WIPE_END
G1 E-.04 F1800
G1 X104.363 Y109.924 Z2.4 F30000
G1 X112.533 Y140.933 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0899599
G1 F15000
G1 X112.416 Y140.816 E.00062
G1 X112.409 Y140.774 E.00016
; WIPE_START
G1 X112.416 Y140.816 E-.15506
G1 X112.533 Y140.933 E-.60494
; WIPE_END
G1 E-.04 F1800
G1 X117.826 Y135.434 Z2.4 F30000
G1 X129.46 Y123.349 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.121486
G1 F15000
G3 X129.263 Y123.643 I-4.968 J-3.111 E.0022
G1 X129.454 Y123.344 F30000
; LINE_WIDTH: 0.183303
G1 F15000
G3 X129.272 Y123.65 I-7.958 J-4.536 E.00395
; WIPE_START
G1 X129.454 Y123.344 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.824 Y123.514 Z2.4 F30000
G1 X116.358 Y123.635 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.201765
G1 F15000
G1 X116.21 Y123.828 E.00305
; LINE_WIDTH: 0.167669
G1 X115.988 Y124.068 E.00322
G1 X115.742 Y124.28 E.0032
; LINE_WIDTH: 0.22115
G1 X115.551 Y124.421 E.00334
; WIPE_START
G1 X115.742 Y124.28 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.688 Y121.122 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.151665
G1 F15000
G3 X115.637 Y121.237 I-.535 J-.165 E.00109
; LINE_WIDTH: 0.11147
G3 X115.551 Y121.337 I-.28 J-.155 E.00072
; WIPE_START
G1 X115.637 Y121.237 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.556 Y117.3 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.128305
G1 F15000
G1 X114.503 Y117.291 E.00036
; LINE_WIDTH: 0.153953
G1 X114.45 Y117.282 E.00047
; LINE_WIDTH: 0.191846
G1 X114.429 Y117.282 E.00024
G1 X114.357 Y117.354 E.0012
G1 X114.357 Y117.375 E.00024
; LINE_WIDTH: 0.153975
G1 X114.366 Y117.428 E.00047
; LINE_WIDTH: 0.128314
G1 X114.375 Y117.481 E.00036
; WIPE_START
G1 X114.366 Y117.428 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.449 Y121.581 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.218086
G1 F15000
G1 X114.259 Y121.722 E.00327
; LINE_WIDTH: 0.166009
G1 X114.01 Y121.936 E.00319
G1 X113.757 Y122.215 E.00366
; LINE_WIDTH: 0.202167
G1 X113.638 Y122.372 E.00248
; WIPE_START
G1 X113.757 Y122.215 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.449 Y124.335 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0989394
G1 F15000
G1 X114.339 Y124.254 E.0006
; WIPE_START
G1 X114.449 Y124.335 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.623 Y128.522 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.136171
G1 F15000
G1 X115.64 Y128.623 E.00075
; LINE_WIDTH: 0.192019
G1 X115.64 Y128.65 E.00032
G1 X115.575 Y128.716 E.00109
G1 X115.548 Y128.716 E.00032
; LINE_WIDTH: 0.13618
G1 X115.447 Y128.698 E.00075
; WIPE_START
G1 X115.548 Y128.716 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.599 Y121.676 Z2.4 F30000
G1 X107.912 Y110.485 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.143024
G1 F15000
G2 X107.954 Y110.199 I-.325 J-.194 E.00235
; WIPE_START
G1 X107.954 Y110.384 E-.47755
G1 X107.912 Y110.485 E-.28245
; WIPE_END
G1 E-.04 F1800
G1 X113.677 Y115.488 Z2.4 F30000
G1 X153.552 Y150.089 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.22168
G1 F15000
G1 X153.324 Y150.409 E.00554
; LINE_WIDTH: 0.266377
G3 X153.193 Y150.573 I-2.404 J-1.783 E.00371
; LINE_WIDTH: 0.299816
G3 X152.784 Y150.974 I-3.299 J-2.954 E.01162
; WIPE_START
G1 X153.193 Y150.573 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X147.773 Y145.2 Z2.4 F30000
G1 X103.215 Y101.026 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.296524
G1 F15000
G2 X102.742 Y101.505 I2.243 J2.69 E.01351
; LINE_WIDTH: 0.254955
G1 X102.676 Y101.591 E.00182
; LINE_WIDTH: 0.221581
G1 X102.448 Y101.911 E.00554
; WIPE_START
G1 X102.676 Y101.591 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.274 Y102.316 Z2.4 F30000
G1 X115.229 Y102.789 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.165407
G1 F15000
G1 X115.089 Y102.739 E.00144
G1 X115.039 Y102.789 E.00068
G1 X115.089 Y102.929 E.00144
; WIPE_START
G1 X115.039 Y102.789 E-.30681
G1 X115.089 Y102.739 E-.14632
G1 X115.229 Y102.789 E-.30686
; WIPE_END
G1 E-.04 F1800
G1 X121.43 Y107.239 Z2.4 F30000
G1 X132.915 Y115.481 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.164031
G1 F15000
G1 X132.96 Y115.617 E.00136
G1 X132.917 Y115.66 E.00059
G1 X132.781 Y115.615 E.00136
; WIPE_START
G1 X132.917 Y115.66 E-.31262
G1 X132.96 Y115.617 E-.13478
G1 X132.915 Y115.481 E-.3126
; WIPE_END
G1 E-.04 F1800
G1 X137.823 Y121.327 Z2.4 F30000
G1 X139.702 Y123.566 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0975522
G1 F15000
G1 X139.621 Y123.444 E.00063
; WIPE_START
G1 X139.702 Y123.566 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.833 Y122.195 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.109237
G1 F15000
G1 X139.701 Y122.365 E.00113
; LINE_WIDTH: 0.159778
G1 X139.632 Y122.466 E.00113
; LINE_WIDTH: 0.191882
G1 X139.567 Y122.569 E.00144
; WIPE_START
G1 X139.632 Y122.466 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.449 Y121.639 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.128437
G1 F15000
G1 X140.284 Y121.761 E.00139
; LINE_WIDTH: 0.0978616
G1 X140.198 Y121.829 E.00047
; WIPE_START
G1 X140.284 Y121.761 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.603 Y117.218 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.108149
G1 F15000
G2 X140.293 Y117.528 I.367 J.677 E.00229
; WIPE_START
G1 X140.379 Y117.397 E-.26798
G1 X140.472 Y117.304 E-.22405
G1 X140.603 Y117.218 E-.26797
; WIPE_END
G1 E-.04 F1800
G1 X133.076 Y115.955 Z2.4 F30000
G1 X119.037 Y113.598 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X119.037 Y104.802 E.28284
G1 X122.963 Y104.802 E.12623
G1 X122.963 Y113.598 E.28284
G1 X119.097 Y113.598 E.1243
M204 S250
G1 X118.645 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.645 Y104.41 E.28536
G1 X123.355 Y104.41 E.14028
G1 X123.355 Y113.99 E.28536
G1 X118.705 Y113.99 E.13849
; WIPE_START
M204 S10000
G1 X118.693 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.496 Y113.139 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X119.496 Y105.321 E.31557
; WIPE_START
G1 X119.496 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.297 Y113.25 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.045 Y113.25 E.02403
G1 X122.045 Y112.369 E.02833
G1 X119.955 Y110.279 E.09502
G1 X119.955 Y111.017 E.02372
G1 X122.045 Y108.927 E.09502
G1 X122.045 Y107.299 E.05236
; WIPE_START
G1 X122.045 Y108.927 E-.61876
G1 X121.782 Y109.19 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.504 Y113.139 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.504 Y105.321 E.31557
; WIPE_START
G1 X122.504 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.789 Y114.92 Z2.4 F30000
G1 X119.037 Y144.198 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X119.037 Y135.402 E.28284
G1 X122.963 Y135.402 E.12623
G1 X122.963 Y144.198 E.28284
G1 X119.097 Y144.198 E.1243
M204 S250
G1 X118.645 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X118.645 Y135.01 E.28536
G1 X123.355 Y135.01 E.14028
G1 X123.355 Y144.59 E.28536
G1 X118.705 Y144.59 E.13849
; WIPE_START
M204 S10000
G1 X118.693 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.496 Y143.739 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X119.496 Y135.921 E.31557
; WIPE_START
G1 X119.496 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.194 Y143.85 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X122.045 Y143.85 E.02737
G1 X122.045 Y143.073 E.02499
G1 X119.955 Y140.983 E.09502
G1 X119.955 Y141.721 E.02372
G1 X122.045 Y139.631 E.09502
G1 X122.045 Y138.003 E.05236
; WIPE_START
G1 X122.045 Y139.631 E-.61876
G1 X121.782 Y139.894 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.504 Y143.739 Z2.4 F30000
G1 Z2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55392
G1 F12000
G1 X122.504 Y135.921 E.31557
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
G1 X122.504 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 11/22
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M106 S99.45
G17
G3 Z2.4 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.16 Y113.598
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P71 R4
G1 F9415
G1 X119.16 Y104.802 E.28284
G1 X122.84 Y104.802 E.11834
G1 X122.84 Y113.598 E.28284
G1 X119.22 Y113.598 E.11641
M204 S250
G1 X118.768 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X118.768 Y104.41 E.28536
G1 X123.232 Y104.41 E.13298
G1 X123.232 Y113.99 E.28536
G1 X118.828 Y113.99 E.13119
; WIPE_START
G1 F12000
M204 S10000
G1 X118.815 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.619 Y113.139 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F9415
G1 X119.619 Y105.321 E.31558
; WIPE_START
G1 F12000
G1 X119.619 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.922 Y107.422 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9415
G1 X121.922 Y109.05 E.05236
G1 X120.078 Y110.894 E.08387
G1 X120.078 Y110.402 E.01583
G1 X121.922 Y112.246 E.08387
G1 X121.922 Y113.25 E.03227
G1 X121.297 Y113.25 E.02009
; WIPE_START
G1 F15476.087
G1 X121.922 Y113.25 E-.23742
G1 X121.922 Y112.246 E-.38134
G1 X121.659 Y111.983 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.381 Y113.139 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F9415
G1 X122.381 Y105.321 E.31558
; WIPE_START
G1 F12000
G1 X122.381 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.398 Y101.298 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X103.002 Y101.298 E.59154
G1 X102.602 Y101.298 E.01286
G1 X102.602 Y101.14 E.00509
M106 S255
G1 F7500
G1 X102.602 Y100.902 E.00764
M106 S99.45
M106 S255
G1 F9000
G1 X102.84 Y100.902 E.00766
M106 S99.45
G1 F9415
G1 X103.24 Y100.902 E.01286
G1 X121.398 Y100.902 E.58388
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X103.074 Y101.69 E.55748
G1 X102.674 Y101.69 E.01191
G1 F7476.073
G1 X102.274 Y101.69 E.01191
G1 F2353.895
G1 X102.21 Y101.69 E.00191
M106 S255
G1 F1800
G1 X102.21 Y101.422 E.00798
M106 S99.45
M106 S255
G1 X102.21 Y101.022 E.01191
M106 S99.45
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F600
G1 X102.21 Y100.51 E.01647
G1 X102.723 Y100.51 E.0165
M106 S99.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F2400
G1 X103.123 Y100.51 E.01191
M106 S99.45
M106 S255
G1 X103.617 Y100.51 E.01472
M106 S99.45
G1 F7558.064
G1 X104.017 Y100.51 E.01191
G1 F9415
G1 X104.417 Y100.51 E.01191
G1 X121.79 Y100.51 E.51747
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z2.6 F30000
G1 X134.602 Y101.298 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X134.602 Y100.902 E.01273
G1 X152.759 Y100.902 E.58387
G1 X153.159 Y100.902 E.01286
M106 S255
G1 F9000
G1 X153.398 Y100.902 E.00768
M106 S99.45
M106 S255
G1 F7500
G1 X153.398 Y101.14 E.00764
M106 S99.45
G1 F9415
G1 X153.398 Y101.298 E.00509
G1 X152.998 Y101.298 E.01286
G1 X134.662 Y101.298 E.58962
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X151.583 Y100.51 E.51748
G1 X151.983 Y100.51 E.01191
G1 F7558.064
G1 X152.383 Y100.51 E.01191
M106 S255
G1 F2400
G1 X152.877 Y100.51 E.01471
M106 S99.45
M106 S255
G1 X153.277 Y100.51 E.01191
M106 S99.45
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F600
G1 X153.79 Y100.51 E.0165
G1 X153.79 Y101.022 E.01647
M106 S99.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F1800
G1 X153.79 Y101.422 E.01191
M106 S99.45
M106 S255
G1 X153.79 Y101.69 E.00798
M106 S99.45
G1 F2353.895
G1 X153.726 Y101.69 E.00191
G1 F7476.073
G1 X153.326 Y101.69 E.01191
G1 F9415
G1 X152.926 Y101.69 E.01191
G1 X134.27 Y101.69 E.55569
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X133.108 Y107.897 Z2.6 F30000
G1 X128.823 Y124.378 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X128.823 Y128.898 E.14535
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.378 E.14535
G2 X128.771 Y124.407 I.823 J-1.404 E.05356
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.407 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.92 Y122.467 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X126.946 Y122.395 E.00227
G3 X127.822 Y121.803 I1.047 J.606 E.03259
G1 X127.953 Y121.791 E.0039
G3 X126.838 Y122.642 I.041 J1.209 E.18191
G1 X126.895 Y122.521 E.00397
M204 S10000
G1 X127.177 Y121.607 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X127.177 Y117.102 E.14488
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.581 I-.827 J1.548 E.05317
; WIPE_START
G1 F15476.087
G1 X127.207 Y119.581 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z2.6 F30000
G1 X142.215 Y128.285 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F9415
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G2 X140.177 Y121.607 I-.827 J1.548 E.05509
G1 X140.177 Y117.102 E.14488
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.586 Y121.508 E-.09173
G1 X141.357 Y121.438 E-.09101
G1 X141.112 Y121.401 E-.09394
G1 X140.938 Y121.399 E-.06631
G1 X140.636 Y121.439 E-.11572
G1 X140.177 Y121.607 E-.18569
G1 X140.177 Y121.303 E-.1156
; WIPE_END
G1 E-.04 F1800
G1 X142.177 Y122.736 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X142.2 Y122.91 E.00522
G3 X140.822 Y121.803 I-1.206 J.09 E.16736
G1 X140.953 Y121.791 E.0039
G3 X142.16 Y122.679 I.041 J1.209 E.04813
; WIPE_START
G1 F12000
M204 S10000
G1 X142.2 Y122.91 E-.08917
G1 X142.207 Y123.093 E-.06968
G1 X142.157 Y123.354 E-.10096
G1 X142.09 Y123.525 E-.06969
G1 X141.946 Y123.755 E-.10298
G1 X141.791 Y123.915 E-.08503
G1 X141.603 Y124.05 E-.08774
G1 X141.359 Y124.156 E-.10096
G1 X141.22 Y124.182 E-.05379
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y128.285 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X141.823 Y128.898 E.01971
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G2 X141.823 Y124.378 I.814 J-1.444 E.05538
G1 X141.823 Y128.225 E.12371
; WIPE_START
G1 F15476.087
G1 X141.823 Y128.898 E-.25572
G1 X140.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X132.866 Y128.708 Z2.6 F30000
G1 X115.823 Y128.285 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F9415
G1 X115.823 Y128.898 E.01971
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G2 X115.823 Y124.378 I.814 J-1.445 E.05538
G1 X115.823 Y128.225 E.12371
; WIPE_START
G1 F15476.087
G1 X115.823 Y128.898 E-.25572
G1 X114.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X116.179 Y122.746 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X116.2 Y122.91 E.00491
G3 X114.822 Y121.803 I-1.206 J.09 E.16736
G1 X114.953 Y121.791 E.0039
G3 X116.163 Y122.689 I.041 J1.209 E.04844
; WIPE_START
G1 F12000
M204 S10000
G1 X116.2 Y122.91 E-.08527
G1 X116.207 Y123.093 E-.06968
G1 X116.157 Y123.354 E-.10096
G1 X116.09 Y123.525 E-.06969
G1 X115.946 Y123.755 E-.10298
G1 X115.791 Y123.915 E-.08503
G1 X115.603 Y124.05 E-.08774
G1 X115.359 Y124.156 E-.10096
G1 X115.21 Y124.184 E-.05768
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G2 X114.177 Y121.607 I-.827 J1.548 E.05509
G1 X114.177 Y117.102 E.14488
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.586 Y121.508 E-.09172
G1 X115.357 Y121.438 E-.09101
G1 X115.112 Y121.401 E-.09394
G1 X114.938 Y121.399 E-.06631
G1 X114.636 Y121.439 E-.11572
G1 X114.177 Y121.607 E-.18569
G1 X114.177 Y121.303 E-.11561
; WIPE_END
G1 E-.04 F1800
G1 X120.854 Y125.001 Z2.6 F30000
G1 X126.785 Y128.285 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z2.6 F30000
G1 X103.215 Y128.285 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F9415
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z2.6 F30000
G1 X153.79 Y116.71 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F9415
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8992.635
M73 P72 R4
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 F9415
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 F9415
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F9415
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F9415
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9415
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 F9415
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 F9415
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F9415
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
G1 F9415
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9415
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z2.6 F30000
G1 X142.019 Y122.027 Z2.6
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.113126
G1 F9415
G1 X141.98 Y121.937 E.00054
G1 X141.887 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.40133
G1 X142.019 Y122.027 E-.35867
; WIPE_END
G1 E-.04 F1800
G1 X140.572 Y121.05 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X141.114 Y121.01 E.01619
G1 X141.431 Y121.071 E.00962
G1 X141.431 Y117.494 E.10655
G1 X140.569 Y117.494 E.02567
G2 X140.571 Y120.99 I303.548 J1.547 E.10412
G1 X141 Y120.587 F30000
; LINE_WIDTH: 0.52759
G1 F9415
G1 X141 Y117.985 E.0996
; WIPE_START
G1 F12998.535
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.143 Y121.859 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114909
G1 F9415
G1 X139.981 Y121.957 E.00108
; WIPE_START
G1 F15000
G1 X140.143 Y121.859 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y123.973 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.113093
G1 F9415
G1 X140.02 Y124.063 E.00054
G1 X140.113 Y124.121 E.00061
G1 X140.569 Y124.943 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X140.569 Y128.506 E.10614
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.931 E.10647
G1 X140.981 Y124.994 E.01355
G1 X140.629 Y124.95 E.01056
; WIPE_START
G1 F15000
G1 X140.981 Y124.994 E-.13476
G1 X141.431 Y124.931 E-.17281
G1 X141.431 Y126.122 E-.45243
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.52759
G1 F9415
G1 X141 Y125.486 E.09912
; WIPE_START
G1 F12998.535
G1 X141 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.055 Y124.321 Z2.6 F30000
G1 X129.019 Y122.027 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113126
G1 F9415
G1 X128.98 Y121.937 E.00054
G1 X128.887 Y121.879 E.00061
G1 X128.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X128.431 Y117.494 E.10655
G1 X127.569 Y117.494 E.02567
G2 X127.572 Y121.05 I319.221 J1.546 E.10591
G1 X128.114 Y121.01 E.01619
G1 X128.372 Y121.06 E.00783
G1 X128 Y120.587 F30000
; LINE_WIDTH: 0.5276
G1 F9415
G1 X128 Y117.985 E.0996
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.143 Y121.859 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11492
G1 F9415
G1 X126.981 Y121.957 E.00108
; WIPE_START
G1 F15000
G1 X127.143 Y121.859 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.981 Y124.994 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X127.569 Y124.942 E.01235
G1 X127.569 Y128.506 E.10614
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.931 E.10647
G1 X128.04 Y124.986 E.01176
; WIPE_START
G1 F15000
G1 X128.431 Y124.931 E-.15001
G1 X128.431 Y126.537 E-.60999
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9415
G1 X128 Y125.486 E.09912
; WIPE_START
G1 F12998.268
G1 X128 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.054 Y124.322 Z2.6 F30000
G1 X116.019 Y122.028 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113125
G1 F9415
G1 X115.98 Y121.937 E.00055
G1 X115.887 Y121.879 E.00061
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X115.431 Y117.494 E.10655
G1 X114.569 Y117.494 E.02567
G2 X114.572 Y121.05 I307.22 J1.546 E.10591
G1 X115.114 Y121.01 E.01619
G1 X115.372 Y121.06 E.00783
G1 X115 Y120.587 F30000
; LINE_WIDTH: 0.5276
G1 F9415
G1 X115 Y117.985 E.0996
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.143 Y121.858 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114929
G1 F9415
G1 X113.981 Y121.957 E.00108
; WIPE_START
G1 F15000
G1 X114.143 Y121.858 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y123.973 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.113075
G1 F9415
G1 X114.02 Y124.063 E.00054
G1 X114.113 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X114.02 Y124.063 E-.40099
G1 X113.981 Y123.973 E-.35901
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y124.931 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9415
G1 X114.981 Y124.994 E.01354
G1 X114.569 Y124.942 E.01235
G1 X114.569 Y128.506 E.10614
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y124.991 E.10468
; WIPE_START
G1 F15000
G1 X115.431 Y126.991 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9415
G1 X115 Y125.486 E.09912
; WIPE_START
G1 F12998.268
G1 X115 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.551 Y132.724 Z2.6 F30000
G1 X139.602 Y150.702 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X152.998 Y150.702 E.43076
G1 X153.398 Y150.702 E.01286
G1 X153.398 Y150.86 E.00509
M106 S255
G1 F7500
G1 X153.398 Y151.098 E.00764
M106 S99.45
M106 S255
G1 F9000
G1 X153.16 Y151.098 E.00766
M106 S99.45
G1 F9415
G1 X152.76 Y151.098 E.01286
G1 X139.602 Y151.098 E.4231
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X152.926 Y150.31 E.40855
G1 X153.326 Y150.31 E.01191
G1 F7476.073
G1 X153.726 Y150.31 E.01191
G1 F2353.895
G1 X153.79 Y150.31 E.00191
M106 S255
G1 F1800
G1 X153.79 Y150.978 E.01989
M106 S99.45
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F3000
G1 X153.79 Y151.49 E.01647
M106 S99.45
M106 S255

G1 X153.277 Y151.49 E.0165
M106 S99.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F2400
G1 X152.383 Y151.49 E.02663
M106 S99.45
G1 F7558.064
G1 X151.983 Y151.49 E.01191
G1 F9415
G1 X151.583 Y151.49 E.01191
G1 X139.21 Y151.49 E.36854
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.361 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z2.6 F30000
G1 X132.398 Y150.702 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.338 Y147.715 Z2.6 F30000
G1 X119.16 Y144.198 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X119.16 Y135.402 E.28284
G1 X122.84 Y135.402 E.11834
G1 X122.84 Y144.198 E.28284
G1 X119.22 Y144.198 E.11641
M204 S250
G1 X118.768 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X118.768 Y135.01 E.28536
G1 X123.232 Y135.01 E.13298
G1 X123.232 Y144.59 E.28536
G1 X118.828 Y144.59 E.13119
; WIPE_START
G1 F12000
M204 S10000
G1 X118.815 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.619 Y143.739 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F9415
G1 X119.619 Y135.921 E.31558
; WIPE_START
G1 F12000
G1 X119.619 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.922 Y138.126 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9415
G1 X121.922 Y139.754 E.05236
G1 X120.078 Y141.598 E.08387
G1 X120.078 Y141.106 E.01583
G1 X121.922 Y142.95 E.08387
G1 X121.922 Y143.85 E.02893
G1 X121.194 Y143.85 E.02343
; WIPE_START
G1 F15476.087
G1 X121.922 Y143.85 E-.27687
G1 X121.922 Y142.95 E-.34189
G1 X121.659 Y142.687 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.381 Y143.739 Z2.6 F30000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55394
G1 F9415
G1 X122.381 Y135.921 E.31558
; WIPE_START
G1 F12000
G1 X122.381 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.145 Y144.834 Z2.6 F30000
G1 X116.398 Y150.702 Z2.6
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9415
G1 X116.398 Y151.098 E.01273
G1 X103.241 Y151.098 E.42309
G1 X102.841 Y151.098 E.01286
M106 S255
G1 F9000
G1 X102.602 Y151.098 E.00767
M106 S99.45
M106 S255
G1 F7500
G1 X102.602 Y150.86 E.00764
M106 S99.45
G1 F9415
G1 X102.602 Y150.702 E.00509
G1 X103.002 Y150.702 E.01286
G1 X116.338 Y150.702 E.42883
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9415
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X104.417 Y151.49 E.36856
G1 X104.017 Y151.49 E.01191
G1 F7558.064
G1 X103.617 Y151.49 E.01191
M106 S255
G1 F2400
G1 X103.123 Y151.49 E.0147
M106 S99.45
M106 S255
G1 X102.723 Y151.49 E.01191
M106 S99.45
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
M106 S255
G1 F600
G1 X102.21 Y151.49 E.0165
G1 X102.21 Y150.978 E.01647
M106 S99.45
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M106 S255
G1 F1800
G1 X102.21 Y150.578 E.01191
M106 S99.45
M106 S255
G1 X102.21 Y150.31 E.00798
M106 S99.45
G1 F2353.895
G1 X102.274 Y150.31 E.00191
G1 F7476.073
G1 X102.674 Y150.31 E.01191
G1 F9415
G1 X103.074 Y150.31 E.01191
G1 X116.73 Y150.31 E.40676
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 12/22
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
G17
G3 Z2.6 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.283 Y113.598
G1 Z2.4
M73 P73 R4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X119.283 Y104.802 E.28284
G1 X122.717 Y104.802 E.11046
G1 X122.717 Y113.598 E.28284
G1 X119.343 Y113.598 E.10853
M204 S250
G1 X118.89 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X118.89 Y104.41 E.28536
G1 X123.11 Y104.41 E.12567
G1 X123.11 Y113.99 E.28536
G1 X118.95 Y113.99 E.12389
; WIPE_START
G1 F12000
M204 S10000
G1 X118.938 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.742 Y113.139 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55402
G1 F9074
G1 X119.742 Y105.321 E.31563
; WIPE_START
G1 F12000
G1 X119.742 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.297 Y113.25 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9074
G1 X121.799 Y113.25 E.01615
G1 X121.799 Y112.123 E.03621
G1 X120.201 Y110.525 E.07271
G1 X120.201 Y110.772 E.00794
G1 X121.799 Y109.173 E.07271
G1 X121.799 Y107.544 E.05236
; WIPE_START
G1 F15476.087
G1 X121.799 Y109.173 E-.61876
G1 X121.537 Y109.436 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.258 Y113.139 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55402
G1 F9074
G1 X122.258 Y105.321 E.31563
; WIPE_START
G1 F12000
G1 X122.258 Y107.321 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.398 Y101.298 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z2.8 F30000
G1 X134.602 Y101.298 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X133.109 Y107.897 Z2.8 F30000
G1 X128.823 Y124.388 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.416 I.823 J-1.482 E.05334
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.908 Y122.48 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X126.905 Y122.473 E.00023
G3 X127.822 Y121.803 I1.088 J.527 E.03521
G1 X127.957 Y121.791 E.00402
G3 X126.838 Y122.644 I.037 J1.209 E.18162
G1 X126.884 Y122.535 E.00352
M204 S10000
G1 X127.177 Y121.612 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.491 E.05331
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z2.8 F30000
G1 X142.215 Y128.285 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F9074
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G2 X140.177 Y121.612 I-.823 J1.491 E.05524
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09174
G1 X141.357 Y121.438 E-.09102
G1 X141.113 Y121.401 E-.0937
G1 X140.943 Y121.399 E-.06466
G1 X140.769 Y121.414 E-.06625
G1 X140.528 Y121.469 E-.09402
G1 X140.177 Y121.612 E-.14389
G1 X140.177 Y121.31 E-.11472
; WIPE_END
G1 E-.04 F1800
G1 X142.182 Y122.747 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X142.199 Y122.91 E.00487
G3 X140.822 Y121.803 I-1.205 J.089 E.16708
G1 X140.957 Y121.791 E.00402
G3 X142.162 Y122.692 I.037 J1.207 E.04837
; WIPE_START
G1 F12000
M204 S10000
G1 X142.199 Y122.91 E-.08415
G1 X142.197 Y123.18 E-.10273
G1 X142.156 Y123.359 E-.06969
G1 X142.05 Y123.603 E-.10093
G1 X141.918 Y123.787 E-.08612
G1 X141.72 Y123.972 E-.10292
G1 X141.525 Y124.09 E-.08667
G1 X141.354 Y124.157 E-.06974
G1 X141.207 Y124.185 E-.05706
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y124.388 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X141.823 Y128.898 E.14502
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G1 X140.415 Y124.492 E.00833
G2 X141.77 Y124.416 I.593 J-1.557 E.04497
; WIPE_START
G1 F15476.087
G1 X141.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.181 Y126.964 Z2.8 F30000
G1 X115.823 Y128.285 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X115.823 Y128.898 E.01971
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G2 X115.823 Y124.388 I.823 J-1.511 E.05519
G1 X115.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X115.823 Y128.898 E-.25572
G1 X114.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X116.184 Y122.761 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X116.199 Y122.91 E.00447
G3 X114.822 Y121.803 I-1.205 J.089 E.16708
G1 X114.957 Y121.791 E.00402
G3 X116.165 Y122.704 I.037 J1.207 E.04875
; WIPE_START
G1 F12000
M204 S10000
G1 X116.199 Y122.91 E-.0793
G1 X116.197 Y123.18 E-.10273
G1 X116.156 Y123.359 E-.06969
G1 X116.05 Y123.603 E-.10093
G1 X115.918 Y123.787 E-.08612
G1 X115.72 Y123.972 E-.10292
G1 X115.525 Y124.09 E-.08667
G1 X115.354 Y124.157 E-.06974
G1 X115.194 Y124.188 E-.0619
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G2 X114.177 Y121.612 I-.823 J1.491 E.05524
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09177
G1 X115.357 Y121.438 E-.091
G1 X115.113 Y121.401 E-.0937
G1 X114.943 Y121.399 E-.06466
G1 X114.769 Y121.414 E-.06625
G1 X114.528 Y121.469 E-.09402
G1 X114.177 Y121.612 E-.14389
G1 X114.177 Y121.31 E-.11472
; WIPE_END
G1 E-.04 F1800
G1 X120.856 Y125.005 Z2.8 F30000
G1 X126.785 Y128.285 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z2.8 F30000
G1 X103.215 Y128.285 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F9074
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z2.8 F30000
G1 X153.79 Y116.71 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F9074
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8992.635
M73 P74 R4
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 F9074
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 F9074
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9074
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 F9074
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 F9074
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9074
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z2.8 F30000
G1 X142.019 Y122.028 Z2.8
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.111109
G1 F9074
G1 X141.98 Y121.937 E.00053
G1 X141.887 Y121.879 E.00059
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.39896
G1 X142.019 Y122.028 E-.36104
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.063 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X141.122 Y121.009 E.01655
G1 X141.431 Y121.071 E.00937
G1 X141.431 Y117.494 E.10655
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y121.003 E.1045
G1 X141 Y120.583 F30000
; LINE_WIDTH: 0.52758
G1 F9074
G1 X141 Y117.985 E.09946
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.113 Y121.879 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113073
G1 F9074
G1 X140.02 Y121.937 E.00061
G1 X139.981 Y122.027 E.00054
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.35831
G1 X140.113 Y121.879 E-.40169
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y123.974 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.112696
G1 F9074
G1 X140.02 Y124.063 E.00054
G1 X140.118 Y124.123 E.00063
G1 X140.569 Y124.929 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X140.569 Y128.506 E.10653
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.928 E.10656
G1 X141 Y124.99 E.01296
G1 X140.629 Y124.938 E.01117
; WIPE_START
G1 F15000
G1 X141 Y124.99 E-.14255
G1 X141.431 Y124.928 E-.16537
G1 X141.431 Y126.118 E-.45208
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.52759
G1 F9074
G1 X141 Y125.481 E.09933
; WIPE_START
G1 F12998.535
G1 X141 Y127.481 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.881 Y124.123 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112611
G1 F9074
G1 X141.98 Y124.063 E.00064
G1 X142.019 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X141.98 Y124.063 E-.34887
G1 X141.881 Y124.123 E-.41113
; WIPE_END
G1 E-.04 F1800
G1 X134.25 Y124.034 Z2.8 F30000
G1 X129.019 Y123.973 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F9074
G1 X128.98 Y124.063 E.00054
G1 X128.881 Y124.123 E.00064
; WIPE_START
G1 F15000
G1 X128.98 Y124.063 E-.41113
G1 X129.019 Y123.973 E-.34887
; WIPE_END
G1 E-.04 F1800
G1 X127.977 Y124.994 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X127.569 Y124.96 E.0122
G1 X127.569 Y128.506 E.10562
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.933 E.10642
G1 X128.037 Y124.986 E.01185
; WIPE_START
G1 F15000
G1 X128.431 Y124.933 E-.15117
G1 X128.431 Y126.535 E-.60883
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9074
G1 X128 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X128 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.119 Y124.123 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112729
G1 F9074
G1 X127.02 Y124.063 E.00064
G1 X126.981 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X127.02 Y124.063 E-.34871
G1 X127.119 Y124.123 E-.41129
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.027 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.11309
G1 F9074
G1 X127.02 Y121.937 E.00054
G1 X127.113 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X127.02 Y121.937 E-.4018
G1 X126.981 Y122.027 E-.3582
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y121.071 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X128.431 Y117.494 E.10655
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.063 E.10629
G1 X128.122 Y121.009 E.01655
G1 X128.372 Y121.059 E.00759
G1 X128 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F9074
G1 X128 Y117.985 E.09946
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.887 Y121.879 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.111109
G1 F9074
G1 X128.98 Y121.937 E.00059
G1 X129.019 Y122.028 E.00053
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.36104
G1 X128.887 Y121.879 E-.39896
; WIPE_END
G1 E-.04 F1800
G1 X121.255 Y121.967 Z2.8 F30000
G1 X116.019 Y122.028 Z2.8
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.111095
G1 F9074
G1 X115.98 Y121.937 E.00053
G1 X115.887 Y121.879 E.00059
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X115.431 Y117.494 E.10655
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.063 E.10629
G1 X115.122 Y121.009 E.01655
G1 X115.372 Y121.059 E.00759
G1 X115 Y120.583 F30000
; LINE_WIDTH: 0.52759
G1 F9074
G1 X115 Y117.985 E.09946
; WIPE_START
G1 F12998.535
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.113 Y121.879 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11309
G1 F9074
G1 X114.02 Y121.937 E.00061
G1 X113.981 Y122.027 E.00054
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.3582
G1 X114.113 Y121.879 E-.4018
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y123.974 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.112729
G1 F9074
G1 X114.02 Y124.063 E.00054
G1 X114.118 Y124.123 E.00064
; WIPE_START
G1 F15000
G1 X114.02 Y124.063 E-.41191
G1 X113.981 Y123.974 E-.34809
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y124.933 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9074
G1 X114.982 Y124.995 E.0135
M73 P74 R3
G1 X114.569 Y124.943 E.01239
G1 X114.569 Y128.506 E.10612
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y124.993 E.10463
; WIPE_START
G1 F15000
G1 X115.431 Y126.993 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9074
G1 X115 Y125.486 E.09911
; WIPE_START
G1 F12998.268
G1 X115 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.882 Y124.123 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112584
G1 F9074
G1 X115.98 Y124.063 E.00063
G1 X116.019 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X115.98 Y124.063 E-.34862
G1 X115.882 Y124.123 E-.41138
; WIPE_END
G1 E-.04 F1800
G1 X120.964 Y129.818 Z2.8 F30000
G1 X139.602 Y150.702 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z2.8 F30000
G1 X132.398 Y150.702 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.354 Y147.687 Z2.8 F30000
G1 X119.283 Y144.198 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X119.283 Y135.402 E.28284
G1 X122.717 Y135.402 E.11046
G1 X122.717 Y144.198 E.28284
G1 X119.343 Y144.198 E.10853
M204 S250
G1 X118.89 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X118.89 Y135.01 E.28536
G1 X123.11 Y135.01 E.12567
G1 X123.11 Y144.59 E.28536
G1 X118.95 Y144.59 E.12389
; WIPE_START
G1 F12000
M204 S10000
G1 X118.938 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.742 Y143.739 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55402
G1 F9074
G1 X119.742 Y135.921 E.31563
; WIPE_START
G1 F12000
G1 X119.742 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.194 Y143.85 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9074
G1 X121.799 Y143.85 E.01948
G1 X121.799 Y142.827 E.03288
G1 X120.201 Y141.228 E.07271
G1 X120.201 Y141.475 E.00794
G1 X121.799 Y139.877 E.07271
G1 X121.799 Y138.248 E.05236
; WIPE_START
G1 F15476.087
G1 X121.799 Y139.877 E-.61876
G1 X121.537 Y140.139 E-.14124
; WIPE_END
G1 E-.04 F1800
G1 X122.258 Y143.739 Z2.8 F30000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.55402
G1 F9074
G1 X122.258 Y135.921 E.31563
; WIPE_START
G1 F12000
G1 X122.258 Y137.921 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.077 Y144.859 Z2.8 F30000
G1 X116.398 Y150.702 Z2.8
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9074
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
M73 P75 R3
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9074
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 13/22
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
G17
G3 Z2.8 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.405 Y113.598
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X119.405 Y104.802 E.28284
G1 X122.595 Y104.802 E.10257
G1 X122.595 Y113.598 E.28284
G1 X119.465 Y113.598 E.10064
M204 S250
G1 X119.013 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X119.013 Y104.41 E.28536
G1 X122.987 Y104.41 E.11837
G1 X122.987 Y113.99 E.28536
G1 X119.073 Y113.99 E.11658
; WIPE_START
G1 F12000
M204 S10000
G1 X119.061 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.203 Y106.397 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9884
G1 X122.203 Y105.194 E.03583
G1 X119.797 Y105.194 E.07165
G1 X119.797 Y113.206 E.23864
G1 X122.203 Y113.206 E.07165
G1 X122.203 Y106.457 E.20102
G1 X121.826 Y106.397 F30000
G1 F9884
G1 X121.826 Y105.571 E.0246
G1 X120.174 Y105.571 E.04919
G1 X120.174 Y112.829 E.21617
G1 X121.826 Y112.829 E.04919
G1 X121.826 Y106.457 E.18979
G1 X121.449 Y106.397 F30000
G1 F9884
G1 X121.449 Y105.948 E.01336
G1 X120.551 Y105.948 E.02673
G1 X120.551 Y112.452 E.19371
G1 X121.449 Y112.452 E.02673
G1 X121.449 Y106.457 E.17856
; WIPE_START
G1 F12000
G1 X121.449 Y108.457 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121 Y112.003 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.56316
G1 F3000;_EXTRUDE_SET_SPEED
G1 X121 Y106.457 E.22792
; Slow Down End
; WIPE_START
G1 X121 Y108.457 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.398 Y101.298 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z3 F30000
G1 X134.602 Y101.298 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X133.108 Y107.897 Z3 F30000
G1 X128.823 Y124.383 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X128.823 Y128.898 E.1452
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.411 I.818 J-1.464 E.0534
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.411 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.903 Y122.492 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X126.906 Y122.473 E.00056
G3 X127.823 Y121.803 I1.087 J.525 E.0352
G1 X127.961 Y121.791 E.00415
G3 X126.839 Y122.645 I.033 J1.207 E.18112
G1 X126.88 Y122.547 E.00316
M204 S10000
G1 X127.177 Y121.612 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.49 E.05332
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z3 F30000
G1 X142.215 Y128.285 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9884
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G2 X140.177 Y121.607 I-.828 J1.547 E.05509
G1 X140.177 Y117.102 E.14486
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09174
G1 X141.357 Y121.438 E-.09105
G1 X141.113 Y121.401 E-.09346
G1 X140.948 Y121.399 E-.063
G1 X140.637 Y121.439 E-.11906
G1 X140.177 Y121.607 E-.18599
G1 X140.177 Y121.302 E-.11571
; WIPE_END
G1 E-.04 F1800
G1 X142.177 Y122.753 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X142.197 Y122.91 E.00471
G3 X140.823 Y121.803 I-1.204 J.087 E.16686
G1 X140.961 Y121.791 E.00415
G3 X142.148 Y122.646 I.033 J1.206 E.04681
G1 X142.162 Y122.695 E.00153
; WIPE_START
G1 F12000
M204 S10000
G1 X142.197 Y122.91 E-.08274
G1 X142.207 Y123.091 E-.06863
G1 X142.156 Y123.357 E-.10294
G1 X142.048 Y123.605 E-.10295
G1 X141.921 Y123.784 E-.08344
G1 X141.754 Y123.946 E-.08832
G1 X141.559 Y124.072 E-.08826
G1 X141.354 Y124.157 E-.08449
G1 X141.203 Y124.186 E-.05824
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y128.285 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X141.823 Y128.898 E.01971
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G2 X141.823 Y124.383 I.818 J-1.491 E.05525
G1 X141.823 Y128.225 E.12356
; WIPE_START
G1 F15476.087
G1 X141.823 Y128.898 E-.25572
G1 X140.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X132.866 Y128.708 Z3 F30000
G1 X115.823 Y128.285 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X115.823 Y128.898 E.01971
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G2 X115.823 Y124.383 I.818 J-1.491 E.05525
G1 X115.823 Y128.225 E.12356
; WIPE_START
G1 F15476.087
G1 X115.823 Y128.898 E-.25572
G1 X114.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X116.18 Y122.77 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X116.197 Y122.91 E.00421
G3 X114.823 Y121.803 I-1.204 J.087 E.16686
G1 X114.961 Y121.791 E.00415
G3 X116.148 Y122.646 I.033 J1.206 E.04681
G1 X116.165 Y122.712 E.00203
; WIPE_START
G1 F12000
M204 S10000
G1 X116.197 Y122.91 E-.07641
G1 X116.207 Y123.091 E-.06863
G1 X116.156 Y123.357 E-.10294
G1 X116.048 Y123.605 E-.10295
G1 X115.921 Y123.784 E-.08344
G1 X115.754 Y123.946 E-.08832
G1 X115.559 Y124.072 E-.08826
G1 X115.354 Y124.157 E-.08449
G1 X115.187 Y124.189 E-.06456
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G2 X114.177 Y121.607 I-.828 J1.546 E.05509
G1 X114.177 Y117.102 E.14486
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09176
G1 X115.357 Y121.438 E-.09103
G1 X115.113 Y121.401 E-.09346
G1 X114.948 Y121.399 E-.063
G1 X114.637 Y121.439 E-.11906
G1 X114.177 Y121.607 E-.18599
G1 X114.177 Y121.302 E-.11571
; WIPE_END
G1 E-.04 F1800
G1 X120.854 Y125 Z3 F30000
G1 X126.785 Y128.285 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z3 F30000
G1 X103.215 Y128.285 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9884
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z3 F30000
G1 X153.79 Y116.71 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9884
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
M73 P76 R3
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.15 Y117.248 E.00478
; LINE_WIDTH: 0.708445
G1 F9466.215
G1 X153.066 Y117.23 E.00454
; LINE_WIDTH: 0.655997
G1 F9884
G1 X152.981 Y117.212 E.00419
G1 X142.019 Y117.212 E.53087
; WIPE_START
G1 F10276.032
G1 X144.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y117.212 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F9884
G1 X129.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y117.212 Z3 F30000
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X116.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y117.212 Z3 F30000
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X103.019 Y117.212 E.53075
; LINE_WIDTH: 0.673387
G1 X102.934 Y117.23 E.0043
; LINE_WIDTH: 0.70844
G1 F9466.282
G1 X102.85 Y117.248 E.00454
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743501
G1 X102.748 Y117.35 E.00478
; LINE_WIDTH: 0.708445
G1 F9466.215
G1 X102.73 Y117.434 E.00454
; LINE_WIDTH: 0.655997
G1 F9884
G1 X102.712 Y117.519 E.00419
G1 X102.712 Y128.481 E.53088
; LINE_WIDTH: 0.673387
G1 X102.73 Y128.566 E.0043
; LINE_WIDTH: 0.70844
G1 F9466.282
G1 X102.748 Y128.65 E.00454
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X102.85 Y128.752 E.00478
; LINE_WIDTH: 0.708445
G1 F9466.215
G1 X102.934 Y128.77 E.00454
; LINE_WIDTH: 0.655997
G1 F9884
G1 X103.019 Y128.788 E.00419
G1 X113.981 Y128.788 E.53087
; WIPE_START
G1 F10276.032
G1 X111.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y128.788 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F9884
G1 X126.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y128.788 Z3 F30000
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X139.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y128.788 Z3 F30000
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X152.981 Y128.788 E.53075
; LINE_WIDTH: 0.673387
G1 X153.066 Y128.77 E.0043
; LINE_WIDTH: 0.70844
G1 F9466.282
G1 X153.15 Y128.752 E.00454
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X153.252 Y128.65 E.00478
; LINE_WIDTH: 0.708445
G1 F9466.215
G1 X153.27 Y128.566 E.00454
; LINE_WIDTH: 0.655997
G1 F9884
G1 X153.288 Y128.481 E.00419
G1 X153.288 Y117.519 E.53088
; LINE_WIDTH: 0.673387
G1 X153.27 Y117.434 E.0043
; LINE_WIDTH: 0.70844
G1 F9466.282
G1 X153.252 Y117.35 E.00454
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.252 Y117.35 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.207 Y120.284 Z3 F30000
G1 X142.019 Y122.028 Z3
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.114347
G1 F9884
G1 X141.98 Y121.937 E.00056
G1 X141.882 Y121.877 E.00065
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.40741
G1 X142.019 Y122.028 E-.35259
; WIPE_END
G1 E-.04 F1800
G1 X140.573 Y121.048 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X141.115 Y121.01 E.01619
G1 X141.431 Y121.071 E.00957
G1 X141.431 Y117.494 E.10655
G1 X140.569 Y117.494 E.02567
G2 X140.573 Y120.988 I194.115 J1.546 E.10407
G1 X141 Y120.587 F30000
; LINE_WIDTH: 0.52758
G1 F9884
G1 X141 Y117.985 E.09961
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.143 Y121.857 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.117228
G1 F9884
G1 X140.025 Y121.927 E.00081
G1 X139.981 Y122.025 E.00063
; WIPE_START
G1 F15000
G1 X140.025 Y121.927 E-.33302
G1 X140.143 Y121.857 E-.42698
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y124.036 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.109898
G1 F9884
G1 X140.118 Y124.123 E.00086
G1 X140.569 Y124.943 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X140.569 Y128.506 E.10611
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.933 E.10641
G1 X140.981 Y124.995 E.01352
G1 X140.629 Y124.951 E.01058
; WIPE_START
G1 F15000
G1 X140.981 Y124.995 E-.13501
G1 X141.431 Y124.933 E-.17243
G1 X141.431 Y126.124 E-.45255
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F9884
G1 X141 Y125.486 E.09911
; WIPE_START
G1 F12998.803
G1 X141 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.913 Y124.099 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108328
G1 F9884
G1 X141.984 Y124.053 E.00044
G1 X142.019 Y123.971 E.00046
; WIPE_START
G1 F15000
G1 X141.984 Y124.053 E-.39156
G1 X141.913 Y124.099 E-.36844
; WIPE_END
G1 E-.04 F1800
G1 X134.281 Y124.023 Z3 F30000
G1 X129.019 Y123.971 Z3
G1 Z2.6
G1 E.8 F1800
G1 F9884
G1 X128.984 Y124.053 E.00046
G1 X128.913 Y124.099 E.00044
; WIPE_START
G1 F15000
G1 X128.984 Y124.053 E-.36844
G1 X129.019 Y123.971 E-.39156
; WIPE_END
G1 E-.04 F1800
G1 X127.977 Y124.994 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X127.569 Y124.96 E.01219
G1 X127.569 Y128.506 E.10561
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.933 E.10642
G1 X128.036 Y124.986 E.01186
; WIPE_START
G1 F15000
G1 X128.431 Y124.933 E-.15127
G1 X128.431 Y126.535 E-.60873
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9884
G1 X128 Y125.486 E.09911
; WIPE_START
G1 F12998.268
G1 X128 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.118 Y124.123 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109896
G1 F9884
G1 X126.981 Y124.036 E.00086
; WIPE_START
G1 F15000
G1 X127.118 Y124.123 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.028 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.11432
G1 F9884
G1 X127.02 Y121.937 E.00056
G1 X127.118 Y121.877 E.00065
; WIPE_START
G1 F15000
G1 X127.02 Y121.937 E-.40801
G1 X126.981 Y122.028 E-.35199
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y121.071 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X128.431 Y117.494 E.10655
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.063 E.10629
G1 X128.123 Y121.01 E.01658
G1 X128.372 Y121.059 E.00756
G1 X128 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F9884
G1 X128 Y117.985 E.09946
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.882 Y121.877 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114347
G1 F9884
G1 X128.98 Y121.937 E.00065
G1 X129.019 Y122.028 E.00056
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.35259
G1 X128.882 Y121.877 E-.40741
; WIPE_END
G1 E-.04 F1800
G1 X121.25 Y121.968 Z3 F30000
G1 X116.019 Y122.03 Z3
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.114359
G1 F9884
G1 X115.98 Y121.937 E.00057
G1 X115.882 Y121.877 E.00065
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X115.431 Y117.494 E.10654
G1 X114.569 Y117.494 E.02567
G2 X114.573 Y121.048 I196.42 J1.547 E.10585
G1 X115.115 Y121.01 E.01619
G1 X115.372 Y121.06 E.00778
G1 X115 Y120.587 F30000
; LINE_WIDTH: 0.52759
G1 F9884
G1 X115 Y117.985 E.09961
; WIPE_START
G1 F12998.535
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.143 Y121.857 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.117261
G1 F9884
G1 X114.025 Y121.927 E.00081
G1 X113.981 Y122.026 E.00064
; WIPE_START
G1 F15000
G1 X114.025 Y121.927 E-.33419
G1 X114.143 Y121.857 E-.42581
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y124.036 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.109921
G1 F9884
G1 X114.118 Y124.123 E.00086
; WIPE_START
G1 F15000
G1 X113.981 Y124.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y124.933 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9884
G1 X114.981 Y124.995 E.01352
G1 X114.569 Y124.943 E.01237
G1 X114.569 Y128.506 E.10611
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y124.993 E.10463
; WIPE_START
G1 F15000
G1 X115.431 Y126.993 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9884
G1 X115 Y125.486 E.09911
; WIPE_START
G1 F12998.268
G1 X115 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.913 Y124.099 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108298
G1 F9884
G1 X115.984 Y124.053 E.00044
G1 X116.019 Y123.971 E.00046
; WIPE_START
G1 F15000
G1 X115.984 Y124.053 E-.39169
G1 X115.913 Y124.099 E-.36831
; WIPE_END
G1 E-.04 F1800
G1 X120.989 Y129.799 Z3 F30000
G1 X139.602 Y150.702 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z3 F30000
G1 X132.398 Y150.702 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.37 Y147.659 Z3 F30000
G1 X119.405 Y144.198 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X119.405 Y135.402 E.28284
G1 X122.595 Y135.402 E.10257
G1 X122.595 Y144.198 E.28284
G1 X119.465 Y144.198 E.10064
M204 S250
G1 X119.013 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X119.013 Y135.01 E.28536
G1 X122.987 Y135.01 E.11837
G1 X122.987 Y144.59 E.28536
G1 X119.073 Y144.59 E.11658
; WIPE_START
G1 F12000
M204 S10000
G1 X119.061 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.203 Y136.997 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F9884
G1 X122.203 Y135.794 E.03583
G1 X119.797 Y135.794 E.07165
G1 X119.797 Y143.806 E.23864
G1 X122.203 Y143.806 E.07165
G1 X122.203 Y137.057 E.20102
G1 X121.826 Y136.997 F30000
G1 F9884
G1 X121.826 Y136.171 E.0246
G1 X120.174 Y136.171 E.04919
G1 X120.174 Y143.429 E.21617
G1 X121.826 Y143.429 E.04919
G1 X121.826 Y137.057 E.18979
M73 P77 R3
G1 X121.449 Y136.997 F30000
G1 F9884
G1 X121.449 Y136.548 E.01336
G1 X120.551 Y136.548 E.02673
G1 X120.551 Y143.052 E.19371
G1 X121.449 Y143.052 E.02673
G1 X121.449 Y137.057 E.17856
; WIPE_START
G1 F12000
G1 X121.449 Y139.057 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121 Y142.603 Z3 F30000
G1 Z2.6
G1 E.8 F1800
; Slow Down Start
; LINE_WIDTH: 0.56316
G1 F3000;_EXTRUDE_SET_SPEED
G1 X121 Y137.057 E.22792
; Slow Down End
; WIPE_START
G1 X121 Y139.057 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.195 Y146.155 Z3 F30000
G1 X116.398 Y150.702 Z3
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9884
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9884
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 14/22
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
G17
G3 Z3 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.528 Y113.598
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X119.528 Y104.802 E.28284
G1 X122.472 Y104.802 E.09469
G1 X122.472 Y113.598 E.28284
G1 X119.588 Y113.598 E.09276
M204 S250
G1 X119.136 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X119.136 Y104.41 E.28536
G1 X122.864 Y104.41 E.11106
G1 X122.864 Y113.99 E.28536
G1 X119.196 Y113.99 E.10928
; WIPE_START
G1 F12000
M204 S10000
G1 X119.183 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.257 Y112.383 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55751
G1 F8933
G1 X121.257 Y106.017 E.25877
G1 X120.743 Y106.017 E.02092
G1 X120.743 Y112.383 E.25877
G1 X121.197 Y112.383 E.01848
G1 X121.703 Y112.829 F30000
; LINE_WIDTH: 0.41999
G1 F8933
G1 X121.703 Y105.571 E.21617
G1 X120.297 Y105.571 E.04189
G1 X120.297 Y112.829 E.21617
G1 X121.643 Y112.829 E.0401
G1 X122.08 Y113.206 F30000
G1 F8933
G1 X122.08 Y105.194 E.23864
G1 X119.92 Y105.194 E.06435
G1 X119.92 Y113.206 E.23864
G1 X122.02 Y113.206 E.06256
; WIPE_START
G1 F15000
G1 X120.02 Y113.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.897 Y105.624 Z3.2 F30000
G1 X121.398 Y101.298 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z3.2 F30000
G1 X134.602 Y101.298 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X133.109 Y107.897 Z3.2 F30000
G1 X128.823 Y124.388 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.415 I.823 J-1.537 E.05319
; WIPE_START
G1 F15476.087
G1 X128.793 Y126.415 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.899 Y122.503 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X126.907 Y122.474 E.0009
G3 X127.823 Y121.803 I1.087 J.524 E.0352
G1 X127.966 Y121.791 E.00427
G3 X126.84 Y122.645 I.029 J1.206 E.18087
G1 X126.876 Y122.558 E.00281
M204 S10000
G1 X127.177 Y121.612 F30000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.489 E.05332
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z3.2 F30000
G1 X142.215 Y128.285 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8933
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G2 X140.177 Y121.612 I-.823 J1.489 E.05524
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.586 Y121.508 E-.09169
G1 X141.357 Y121.438 E-.09108
G1 X141.114 Y121.401 E-.09327
G1 X140.953 Y121.399 E-.06126
G1 X140.77 Y121.414 E-.06974
G1 X140.528 Y121.469 E-.09438
G1 X140.177 Y121.612 E-.14387
G1 X140.177 Y121.31 E-.11471
; WIPE_END
G1 E-.04 F1800
G1 X142.177 Y122.754 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X142.198 Y122.91 E.0047
G3 X140.823 Y121.803 I-1.204 J.087 E.16685
G1 X140.966 Y121.791 E.00427
G3 X142.149 Y122.646 I.029 J1.206 E.04669
G1 X142.162 Y122.696 E.00154
; WIPE_START
G1 F12000
M204 S10000
G1 X142.198 Y122.91 E-.08261
G1 X142.197 Y123.18 E-.10266
G1 X142.127 Y123.442 E-.10296
G1 X142.047 Y123.608 E-.06991
G1 X141.887 Y123.824 E-.10218
G1 X141.684 Y123.999 E-.10185
G1 X141.525 Y124.09 E-.06954
G1 X141.354 Y124.157 E-.06987
G1 X141.203 Y124.186 E-.0584
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y128.285 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X141.823 Y128.898 E.01971
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G2 X141.823 Y124.388 I.823 J-1.51 E.05519
G1 X141.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X141.823 Y128.898 E-.25572
G1 X140.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X132.988 Y127.526 Z3.2 F30000
G1 X115.823 Y124.388 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8933
G1 X115.823 Y128.898 E.14502
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G1 X114.414 Y124.492 E.00833
G2 X115.77 Y124.416 I.594 J-1.556 E.04498
; WIPE_START
G1 F15476.087
G1 X115.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.181 Y122.772 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X116.198 Y122.91 E.00415
G3 X114.823 Y121.803 I-1.204 J.087 E.16685
G1 X114.966 Y121.791 E.00427
G3 X116.149 Y122.646 I.029 J1.206 E.04669
G1 X116.166 Y122.714 E.00209
; WIPE_START
G1 F12000
M204 S10000
G1 X116.198 Y122.91 E-.07566
G1 X116.197 Y123.18 E-.10266
G1 X116.127 Y123.442 E-.10296
G1 X116.047 Y123.608 E-.06991
G1 X115.887 Y123.824 E-.10218
G1 X115.684 Y123.999 E-.10185
G1 X115.525 Y124.09 E-.06954
G1 X115.354 Y124.157 E-.06987
G1 X115.185 Y124.189 E-.06535
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G2 X114.177 Y121.612 I-.823 J1.489 E.05524
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.586 Y121.508 E-.0917
G1 X115.357 Y121.438 E-.09106
G1 X115.114 Y121.401 E-.09327
G1 X114.953 Y121.399 E-.06126
G1 X114.77 Y121.414 E-.06974
G1 X114.528 Y121.469 E-.09438
G1 X114.177 Y121.612 E-.14387
G1 X114.177 Y121.31 E-.11471
; WIPE_END
G1 E-.04 F1800
G1 X120.856 Y125.005 Z3.2 F30000
G1 X126.785 Y128.285 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z3.2 F30000
G1 X103.215 Y128.285 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8933
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
M73 P78 R3
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z3.2 F30000
G1 X153.79 Y116.71 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F8933
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743501
G1 F8933
G1 X153.15 Y117.248 E.00478
; LINE_WIDTH: 0.708445
G1 X153.066 Y117.23 E.00454
; LINE_WIDTH: 0.655997
G1 X152.981 Y117.212 E.00419
G1 X142.019 Y117.212 E.53087
; WIPE_START
G1 F10276.032
G1 X144.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y117.212 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F8933
G1 X129.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y117.212 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
G1 F8933
G1 X116.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y117.212 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
G1 F8933
G1 X103.019 Y117.212 E.53075
; LINE_WIDTH: 0.673387
G1 X102.934 Y117.23 E.0043
; LINE_WIDTH: 0.70844
G1 X102.85 Y117.248 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743501
G1 X102.748 Y117.35 E.00478
; LINE_WIDTH: 0.708445
G1 X102.73 Y117.434 E.00454
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.00419
G1 X102.712 Y128.481 E.53088
; LINE_WIDTH: 0.673387
G1 X102.73 Y128.566 E.0043
; LINE_WIDTH: 0.70844
G1 X102.748 Y128.65 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X102.85 Y128.752 E.00478
; LINE_WIDTH: 0.708445
G1 X102.934 Y128.77 E.00454
; LINE_WIDTH: 0.655997
G1 X103.019 Y128.788 E.00419
G1 X113.981 Y128.788 E.53087
; WIPE_START
G1 F10276.032
G1 X111.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y128.788 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F8933
G1 X126.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y128.788 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
G1 F8933
G1 X139.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y128.788 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
G1 F8933
G1 X152.981 Y128.788 E.53075
; LINE_WIDTH: 0.673387
G1 X153.066 Y128.77 E.0043
; LINE_WIDTH: 0.70844
G1 X153.15 Y128.752 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X153.252 Y128.65 E.00478
; LINE_WIDTH: 0.708445
G1 X153.27 Y128.566 E.00454
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.00419
G1 X153.288 Y117.519 E.53088
; LINE_WIDTH: 0.673387
G1 X153.27 Y117.434 E.0043
; LINE_WIDTH: 0.70844
G1 X153.252 Y117.35 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 F8992.635
G1 X153.252 Y117.35 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.206 Y120.283 Z3.2 F30000
G1 X142.019 Y122.026 Z3.2
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.11279
G1 F8933
G1 X141.98 Y121.937 E.00054
G1 X141.882 Y121.877 E.00063
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.41023
G1 X142.019 Y122.026 E-.34977
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.063 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X141.124 Y121.01 E.0166
G1 X141.431 Y121.071 E.00932
G1 X141.431 Y117.494 E.10655
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y121.003 E.10451
G1 X141 Y120.583 F30000
; LINE_WIDTH: 0.52758
G1 F8933
G1 X141 Y117.985 E.09946
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y124.036 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110153
G1 F8933
G1 X140.119 Y124.123 E.00087
G1 X140.569 Y124.977 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X140.569 Y128.506 E.1051
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.933 E.10641
G3 X140.629 Y124.98 I-.531 J-2.224 E.02405
; WIPE_START
G1 F15000
G1 X140.981 Y124.995 E-.13371
G1 X141.431 Y124.933 E-.17266
G1 X141.431 Y126.127 E-.45363
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F8933
G1 X141 Y125.486 E.09911
; WIPE_START
G1 F12998.803
G1 X141 Y127.486 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.055 Y124.321 Z3.2 F30000
G1 X129.019 Y122.026 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11279
G1 F8933
G1 X128.98 Y121.937 E.00054
G1 X128.882 Y121.877 E.00063
G1 X128.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X128.431 Y117.494 E.10655
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.063 E.10629
G1 X128.124 Y121.01 E.0166
G1 X128.372 Y121.059 E.00753
G1 X128 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F8933
G1 X128 Y117.985 E.09947
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y123.972 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114304
G1 F8933
G1 X127.02 Y124.063 E.00056
G1 X127.118 Y124.123 E.00064
; WIPE_START
G1 F15000
G1 X127.02 Y124.063 E-.40785
G1 X126.981 Y123.972 E-.35215
; WIPE_END
G1 E-.04 F1800
G1 X127.968 Y124.995 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X127.569 Y124.967 E.0119
G1 X127.569 Y128.506 E.10542
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.933 E.10642
G1 X128.027 Y124.987 E.01214
; WIPE_START
G1 F15000
G1 X128.431 Y124.933 E-.15482
G1 X128.431 Y126.526 E-.60518
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F8933
G1 X128 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X128 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.055 Y124.322 Z3.2 F30000
G1 X116.019 Y122.027 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112776
G1 F8933
G1 X115.98 Y121.937 E.00054
G1 X115.882 Y121.877 E.00063
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X115.431 Y117.494 E.10655
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.063 E.10629
G1 X115.124 Y121.01 E.0166
G1 X115.372 Y121.059 E.00753
G1 X115 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F8933
G1 X115 Y117.985 E.09947
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y124.036 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110147
G1 F8933
G1 X114.119 Y124.123 E.00087
; WIPE_START
G1 F15000
G1 X113.981 Y124.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y125.178 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8933
G1 X115.431 Y124.928 E.00744
G1 X115 Y124.99 E.01296
G1 X114.569 Y124.93 E.01296
G1 X114.569 Y128.506 E.10652
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.238 E.09734
; WIPE_START
G1 F15000
G1 X115.431 Y127.238 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; LINE_WIDTH: 0.52759
G1 F8933
G1 X115 Y125.481 E.09933
; WIPE_START
G1 F12998.535
G1 X115 Y127.481 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.55 Y132.72 Z3.2 F30000
G1 X139.602 Y150.702 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z3.2 F30000
G1 X132.398 Y150.702 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.386 Y147.631 Z3.2 F30000
G1 X119.528 Y144.198 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X119.528 Y135.402 E.28284
G1 X122.472 Y135.402 E.09469
G1 X122.472 Y144.198 E.28284
G1 X119.588 Y144.198 E.09276
M204 S250
G1 X119.136 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X119.136 Y135.01 E.28536
G1 X122.864 Y135.01 E.11106
G1 X122.864 Y144.59 E.28536
G1 X119.196 Y144.59 E.10928
; WIPE_START
G1 F12000
M204 S10000
G1 X119.183 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.257 Y136.617 Z3.2 F30000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.55751
G1 F8933
G1 X120.743 Y136.617 E.02092
G1 X120.743 Y142.983 E.25877
G1 X121.257 Y142.983 E.02092
G1 X121.257 Y136.677 E.25633
G1 X121.703 Y136.171 F30000
; LINE_WIDTH: 0.41999
G1 F8933
G1 X120.297 Y136.171 E.04189
G1 X120.297 Y143.429 E.21617
G1 X121.703 Y143.429 E.04189
G1 X121.703 Y136.231 E.21439
G1 X122.08 Y135.794 F30000
G1 F8933
G1 X119.92 Y135.794 E.06435
G1 X119.92 Y143.806 E.23864
G1 X122.08 Y143.806 E.06435
G1 X122.08 Y135.854 E.23685
; WIPE_START
G1 F15000
G1 X122.08 Y137.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.993 Y144.834 Z3.2 F30000
M73 P79 R3
G1 X116.398 Y150.702 Z3.2
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8933
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8933
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 15/22
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
G17
G3 Z3.2 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.65 Y113.598
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X119.65 Y104.802 E.28284
G1 X122.35 Y104.802 E.0868
G1 X122.35 Y113.598 E.28284
G1 X119.71 Y113.598 E.08487
M204 S250
G1 X119.258 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X119.258 Y104.41 E.28536
G1 X122.742 Y104.41 E.10376
G1 X122.742 Y113.99 E.28536
G1 X119.318 Y113.99 E.10197
; WIPE_START
G1 F12000
M204 S10000
G1 X119.306 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.196 Y112.444 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43491
G1 F9267
G1 X121.196 Y105.956 E.20091
G1 X120.804 Y105.956 E.01214
G1 X120.804 Y112.444 E.20091
G1 X121.136 Y112.444 E.01028
G1 X121.581 Y112.829 F30000
; LINE_WIDTH: 0.41999
G1 F9267
G1 X121.581 Y105.571 E.21617
G1 X120.419 Y105.571 E.03458
G1 X120.419 Y112.829 E.21617
G1 X121.521 Y112.829 E.0328
G1 X121.958 Y113.206 F30000
G1 F9267
G1 X121.958 Y105.194 E.23864
G1 X120.042 Y105.194 E.05705
G1 X120.042 Y113.206 E.23864
G1 X121.898 Y113.206 E.05526
; WIPE_START
G1 F15000
G1 X120.042 Y113.206 E-.70497
G1 X120.042 Y113.061 E-.05503
; WIPE_END
G1 E-.04 F1800
G1 X120.916 Y105.479 Z3.4 F30000
G1 X121.398 Y101.298 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z3.4 F30000
G1 X134.602 Y101.298 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X132.644 Y107.761 Z3.4 F30000
G1 X127.177 Y124.388 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X127.414 Y124.492 E.00833
G2 X128.823 Y124.388 I.594 J-1.557 E.0469
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.448 E.14309
; WIPE_START
G1 F15476.087
G1 X127.414 Y124.492 E-.09169
G1 X127.685 Y124.571 E-.10713
G1 X127.871 Y124.598 E-.07143
G1 X128.125 Y124.598 E-.09659
G1 X128.464 Y124.534 E-.13089
G1 X128.823 Y124.388 E-.14736
G1 X128.823 Y124.691 E-.1149
; WIPE_END
G1 E-.04 F1800
G1 X126.894 Y122.514 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X126.907 Y122.474 E.00127
G3 X127.823 Y121.803 I1.088 J.524 E.03521
G1 X127.97 Y121.791 E.00439
G3 X126.84 Y122.646 I.025 J1.207 E.18091
G1 X126.871 Y122.57 E.00244
; WIPE_START
G1 F12000
M204 S10000
G1 X126.907 Y122.474 E-.03896
G1 X127.036 Y122.27 E-.0917
G1 X127.177 Y122.113 E-.08011
G1 X127.395 Y121.952 E-.10297
G1 X127.643 Y121.844 E-.103
G1 X127.823 Y121.803 E-.06997
G1 X127.97 Y121.791 E-.05605
G1 X128.18 Y121.803 E-.08011
G1 X128.442 Y121.874 E-.10302
G1 X128.521 Y121.915 E-.0341
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.488 E.05332
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z3.4 F30000
G1 X142.215 Y128.285 Z3.4
G1 Z3
G1 E.8 F1800
G1 F9267
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G2 X140.177 Y121.612 I-.823 J1.488 E.05525
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09176
G1 X141.357 Y121.438 E-.09101
G1 X141.115 Y121.401 E-.09301
G1 X140.958 Y121.398 E-.05965
G1 X140.77 Y121.414 E-.07142
G1 X140.528 Y121.469 E-.09456
G1 X140.177 Y121.612 E-.14388
G1 X140.177 Y121.31 E-.11471
; WIPE_END
G1 E-.04 F1800
G1 X142.185 Y122.775 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X142.204 Y122.998 E.00666
G3 X140.823 Y121.803 I-1.209 J.002 E.16465
G1 X140.97 Y121.791 E.00439
G3 X142.171 Y122.717 I.025 J1.209 E.04883
; WIPE_START
G1 F12000
M204 S10000
G1 X142.204 Y122.998 E-.10753
G1 X142.197 Y123.18 E-.06929
G1 X142.126 Y123.442 E-.10299
G1 X142 Y123.682 E-.10301
G1 X141.887 Y123.823 E-.06872
G1 X141.755 Y123.946 E-.06869
G1 X141.525 Y124.09 E-.10302
G1 X141.354 Y124.157 E-.06991
G1 X141.181 Y124.19 E-.06684
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y124.388 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X141.823 Y128.898 E.14502
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G1 X140.414 Y124.492 E.00833
G2 X141.77 Y124.416 I.594 J-1.557 E.04498
; WIPE_START
G1 F15476.087
G1 X141.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.184 Y125.822 Z3.4 F30000
G1 X115.823 Y124.388 Z3.4
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X115.823 Y128.898 E.14502
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G1 X114.414 Y124.492 E.00833
G2 X115.77 Y124.416 I.594 J-1.557 E.04497
; WIPE_START
G1 F15476.087
G1 X115.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.188 Y122.798 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X116.204 Y122.998 E.00597
G3 X114.823 Y121.803 I-1.209 J.002 E.16465
G1 X114.97 Y121.791 E.00439
G3 X116.175 Y122.733 I.025 J1.209 E.04932
G1 X116.176 Y122.739 E.00019
; WIPE_START
G1 F12000
M204 S10000
G1 X116.204 Y122.998 E-.09889
G1 X116.197 Y123.18 E-.06929
G1 X116.126 Y123.442 E-.10299
G1 X116 Y123.682 E-.10301
G1 X115.887 Y123.823 E-.06872
G1 X115.755 Y123.946 E-.06869
G1 X115.525 Y124.09 E-.10302
G1 X115.354 Y124.157 E-.06991
G1 X115.159 Y124.194 E-.07547
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G2 X114.177 Y121.612 I-.823 J1.488 E.05524
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09174
G1 X115.357 Y121.438 E-.09103
G1 X115.115 Y121.401 E-.09301
G1 X114.958 Y121.398 E-.05965
G1 X114.77 Y121.414 E-.07142
G1 X114.528 Y121.469 E-.09456
G1 X114.177 Y121.612 E-.14388
G1 X114.177 Y121.31 E-.11472
; WIPE_END
G1 E-.04 F1800
G1 X120.856 Y125.005 Z3.4 F30000
G1 X126.785 Y128.285 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z3.4 F30000
G1 X103.215 Y128.285 Z3.4
G1 Z3
G1 E.8 F1800
G1 F9267
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z3.4 F30000
G1 X153.79 Y116.71 Z3.4
G1 Z3
G1 E.8 F1800
G1 F9267
M204 S5000
M73 P80 R3
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 F9267
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 F9267
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z3.4 F30000
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z3.4 F30000
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9267
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 F9267
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 F9267
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z3.4 F30000
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z3.4 F30000
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9267
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z3.4 F30000
G1 X142.019 Y122.028 Z3.4
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.111542
G1 F9267
G1 X141.98 Y121.937 E.00054
G1 X141.887 Y121.879 E.00059
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.39998
G1 X142.019 Y122.028 E-.36002
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.063 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X141.125 Y121.01 E.01663
G1 X141.431 Y121.071 E.00929
G1 X141.431 Y117.494 E.10654
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y121.003 E.10451
G1 X141 Y120.583 F30000
; LINE_WIDTH: 0.52758
G1 F9267
G1 X141 Y117.985 E.09947
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.113 Y121.879 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113037
G1 F9267
G1 X140.02 Y121.937 E.00061
G1 X139.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.35974
G1 X140.113 Y121.879 E-.40026
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y124.036 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.110428
G1 F9267
G1 X140.119 Y124.123 E.00087
G1 X140.569 Y124.93 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X140.569 Y128.506 E.10652
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.928 E.10657
G1 X141 Y124.99 E.01296
G1 X140.629 Y124.938 E.01118
; WIPE_START
G1 F15000
G1 X141 Y124.99 E-.1426
G1 X141.431 Y124.928 E-.16532
G1 X141.431 Y126.118 E-.45208
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.52759
G1 F9267
G1 X141 Y125.481 E.09933
; WIPE_START
G1 F12998.535
G1 X141 Y127.481 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.887 Y124.121 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113058
G1 F9267
G1 X141.98 Y124.063 E.00061
G1 X142.019 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X141.98 Y124.063 E-.3582
G1 X141.887 Y124.121 E-.4018
; WIPE_END
G1 E-.04 F1800
G1 X134.255 Y124.034 Z3.4 F30000
G1 X129.019 Y123.973 Z3.4
G1 Z3
G1 E.8 F1800
G1 F9267
G1 X128.98 Y124.063 E.00054
G1 X128.887 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X128.98 Y124.063 E-.4018
G1 X129.019 Y123.973 E-.3582
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y125.179 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X128.431 Y124.928 E.00746
G1 X128 Y124.99 E.01296
G1 X127.569 Y124.93 E.01296
G1 X127.569 Y128.506 E.10652
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y125.239 E.09731
; WIPE_START
G1 F15000
G1 X128.431 Y127.239 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9267
G1 X128 Y125.481 E.09933
; WIPE_START
G1 F12998.268
G1 X128 Y127.481 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.119 Y124.123 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110437
G1 F9267
G1 X126.981 Y124.036 E.00087
; WIPE_START
G1 F15000
G1 X127.119 Y124.123 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.027 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.113018
G1 F9267
G1 X127.02 Y121.937 E.00054
G1 X127.113 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X127.02 Y121.937 E-.40153
G1 X126.981 Y122.027 E-.35847
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y121.071 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X128.431 Y117.494 E.10654
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.063 E.10629
G1 X128.125 Y121.01 E.01663
G1 X128.372 Y121.059 E.0075
G1 X128 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F9267
G1 X128 Y117.985 E.09947
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.887 Y121.879 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.111542
G1 F9267
G1 X128.98 Y121.937 E.00059
G1 X129.019 Y122.028 E.00054
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.36002
G1 X128.887 Y121.879 E-.39998
; WIPE_END
G1 E-.04 F1800
G1 X121.255 Y121.967 Z3.4 F30000
G1 X116.019 Y122.028 Z3.4
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.111544
G1 F9267
G1 X115.98 Y121.937 E.00054
G1 X115.887 Y121.879 E.00059
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X115.431 Y117.494 E.10654
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.063 E.10629
G1 X115.125 Y121.01 E.01663
G1 X115.372 Y121.059 E.0075
G1 X115 Y120.583 F30000
; LINE_WIDTH: 0.5276
G1 F9267
G1 X115 Y117.985 E.09947
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.113 Y121.879 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113048
G1 F9267
G1 X114.02 Y121.937 E.00061
G1 X113.981 Y122.027 E.00054
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.35894
G1 X114.113 Y121.879 E-.40106
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y124.036 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.110417
G1 F9267
G1 X114.119 Y124.123 E.00087
; WIPE_START
G1 F15000
G1 X113.981 Y124.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y125.179 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9267
G1 X115.431 Y124.928 E.00746
G1 X115 Y124.99 E.01296
G1 X114.569 Y124.93 E.01296
G1 X114.569 Y128.506 E.10652
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.239 E.09731
; WIPE_START
G1 F15000
G1 X115.431 Y127.239 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; LINE_WIDTH: 0.52759
G1 F9267
G1 X115 Y125.481 E.09933
; WIPE_START
G1 F12998.535
G1 X115 Y127.481 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.887 Y124.121 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113064
G1 F9267
G1 X115.98 Y124.063 E.00061
G1 X116.019 Y123.972 E.00055
; WIPE_START
G1 F15000
G1 X115.98 Y124.063 E-.36006
G1 X115.887 Y124.121 E-.39994
; WIPE_END
G1 E-.04 F1800
G1 X120.968 Y129.816 Z3.4 F30000
G1 X139.602 Y150.702 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z3.4 F30000
G1 X132.398 Y150.702 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.403 Y147.603 Z3.4 F30000
G1 X119.65 Y144.198 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X119.65 Y135.402 E.28284
G1 X122.35 Y135.402 E.0868
G1 X122.35 Y144.198 E.28284
G1 X119.71 Y144.198 E.08487
M204 S250
G1 X119.258 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X119.258 Y135.01 E.28536
G1 X122.742 Y135.01 E.10376
G1 X122.742 Y144.59 E.28536
G1 X119.318 Y144.59 E.10197
; WIPE_START
M73 P80 R2
G1 F12000
M204 S10000
G1 X119.306 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.196 Y136.556 Z3.4 F30000
G1 Z3
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43491
G1 F9267
G1 X120.804 Y136.556 E.01214
G1 X120.804 Y143.044 E.20091
G1 X121.196 Y143.044 E.01214
M73 P81 R2
G1 X121.196 Y136.616 E.19906
G1 X121.581 Y136.171 F30000
; LINE_WIDTH: 0.41999
G1 F9267
G1 X120.419 Y136.171 E.03458
G1 X120.419 Y143.429 E.21617
G1 X121.581 Y143.429 E.03458
G1 X121.581 Y136.231 E.21439
G1 X121.958 Y135.794 F30000
G1 F9267
G1 X120.042 Y135.794 E.05705
G1 X120.042 Y143.806 E.23864
G1 X121.958 Y143.806 E.05705
G1 X121.958 Y135.854 E.23685
; WIPE_START
G1 F15000
G1 X121.958 Y137.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.926 Y144.859 Z3.4 F30000
G1 X116.398 Y150.702 Z3.4
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9267
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9267
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 16/22
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
G17
G3 Z3.4 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.773 Y113.598
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X119.773 Y104.802 E.28284
G1 X122.227 Y104.802 E.07892
G1 X122.227 Y113.598 E.28284
G1 X119.833 Y113.598 E.07699
M204 S250
G1 X119.381 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X119.381 Y104.41 E.28536
G1 X122.619 Y104.41 E.09646
G1 X122.619 Y113.99 E.28536
G1 X119.441 Y113.99 E.09467
; WIPE_START
G1 F12000
M204 S10000
G1 X119.428 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121 Y112.371 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5817
G1 F9020
G1 X121 Y106.089 E.26735
; WIPE_START
G1 F11693.085
G1 X121 Y108.089 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.458 Y112.829 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F9020
G1 X121.458 Y105.571 E.21617
G1 X120.542 Y105.571 E.02728
G1 X120.542 Y112.829 E.21617
G1 X121.398 Y112.829 E.02549
G1 X121.835 Y113.206 F30000
G1 F9020
G1 X121.835 Y105.194 E.23864
G1 X120.165 Y105.194 E.04974
G1 X120.165 Y113.206 E.23864
G1 X121.775 Y113.206 E.04795
; WIPE_START
G1 F15000
G1 X120.165 Y113.206 E-.6118
G1 X120.165 Y112.816 E-.1482
; WIPE_END
G1 E-.04 F1800
G1 X120.977 Y105.227 Z3.6 F30000
G1 X121.398 Y101.298 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z3.6 F30000
G1 X134.602 Y101.298 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X133.109 Y107.897 Z3.6 F30000
G1 X128.823 Y124.388 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.416 I.823 J-1.508 E.05326
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.899 Y122.517 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X126.95 Y122.393 E.00398
G3 X127.823 Y121.803 I1.046 J.605 E.0325
G1 X127.974 Y121.791 E.00452
G3 X126.841 Y122.642 I.021 J1.208 E.18102
G1 X126.874 Y122.572 E.00232
; WIPE_START
G1 F12000
M204 S10000
G1 X126.95 Y122.393 E-.07356
G1 X127.054 Y122.245 E-.06883
G1 X127.178 Y122.112 E-.06931
G1 X127.392 Y121.954 E-.10109
G1 X127.643 Y121.844 E-.10427
G1 X127.823 Y121.803 E-.07003
G1 X127.974 Y121.791 E-.05763
G1 X128.18 Y121.803 E-.07847
G1 X128.442 Y121.874 E-.10302
G1 X128.521 Y121.915 E-.03379
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.487 E.05333
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z3.6 F30000
G1 X142.215 Y128.285 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9020
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G2 X140.177 Y121.612 I-.823 J1.487 E.05525
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09176
G1 X141.357 Y121.438 E-.09098
G1 X140.963 Y121.398 E-.15045
G1 X140.771 Y121.414 E-.07323
G1 X140.528 Y121.469 E-.09466
G1 X140.177 Y121.612 E-.14391
G1 X140.177 Y121.309 E-.115
; WIPE_END
G1 E-.04 F1800
G1 X142.187 Y122.781 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X142.201 Y122.91 E.00386
G3 X140.823 Y121.803 I-1.205 J.089 E.16714
G1 X140.974 Y121.791 E.00452
G3 X142.172 Y122.723 I.021 J1.208 E.04889
; WIPE_START
G1 F12000
M204 S10000
G1 X142.201 Y122.91 E-.0718
G1 X142.207 Y123.091 E-.06866
G1 X142.156 Y123.357 E-.10299
G1 X142.06 Y123.582 E-.09315
G1 X141.944 Y123.757 E-.0798
G1 X141.756 Y123.945 E-.10104
G1 X141.525 Y124.09 E-.10363
G1 X141.357 Y124.156 E-.06873
G1 X141.175 Y124.191 E-.07021
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y128.285 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X141.823 Y128.898 E.01971
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.391 E.14493
G2 X141.823 Y124.388 I.82 J-1.493 E.05523
G1 X141.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X141.823 Y128.898 E-.25572
G1 X140.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X132.866 Y128.708 Z3.6 F30000
G1 X115.823 Y128.285 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9020
G1 X115.823 Y128.898 E.01971
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.391 E.14493
G2 X115.823 Y124.388 I.82 J-1.493 E.05523
G1 X115.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X115.823 Y128.898 E-.25572
G1 X114.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X116.191 Y122.805 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X116.201 Y122.91 E.00313
G3 X114.823 Y121.803 I-1.205 J.089 E.16714
G1 X114.974 Y121.791 E.00452
G3 X116.174 Y122.732 I.021 J1.208 E.04916
G1 X116.178 Y122.747 E.00045
; WIPE_START
G1 F12000
M204 S10000
G1 X116.201 Y122.91 E-.06263
G1 X116.207 Y123.091 E-.06866
G1 X116.156 Y123.357 E-.10299
G1 X116.06 Y123.582 E-.09315
G1 X115.944 Y123.757 E-.07981
G1 X115.756 Y123.945 E-.10104
G1 X115.525 Y124.09 E-.10363
G1 X115.357 Y124.156 E-.06873
G1 X115.151 Y124.195 E-.07937
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G2 X114.177 Y121.612 I-.823 J1.487 E.05525
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.586 Y121.508 E-.09173
G1 X115.357 Y121.438 E-.091
G1 X114.963 Y121.398 E-.15045
G1 X114.771 Y121.414 E-.07323
G1 X114.528 Y121.469 E-.09466
G1 X114.177 Y121.612 E-.14392
G1 X114.177 Y121.309 E-.115
; WIPE_END
G1 E-.04 F1800
G1 X120.855 Y125.004 Z3.6 F30000
G1 X126.785 Y128.285 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z3.6 F30000
G1 X103.215 Y128.285 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9020
M204 S5000
G1 X103.215 Y117.715 E.31484
M73 P82 R2
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z3.6 F30000
G1 X153.79 Y116.71 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F9020
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 F9020
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 F9020
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
G1 F9020
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
G1 F9020
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9020
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 F9020
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 F9020
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
G1 F9020
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
G1 F9020
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9020
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z3.6 F30000
G1 X142.019 Y122.028 Z3.6
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.113073
G1 F9020
G1 X141.98 Y121.937 E.00055
G1 X141.887 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.3999
G1 X142.019 Y122.028 E-.3601
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.066 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X140.983 Y121.006 E.01247
G1 X141.431 Y121.036 E.01336
G1 X141.431 Y117.494 E.10551
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y121.006 E.10462
G1 X141 Y120.575 F30000
; LINE_WIDTH: 0.52759
G1 F9020
G1 X141 Y117.985 E.09917
; WIPE_START
G1 F12998.535
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.117 Y121.878 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114145
G1 F9020
G1 X140.02 Y121.937 E.00064
G1 X139.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.35231
G1 X140.117 Y121.878 E-.40769
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y123.974 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.115618
G1 F9020
G1 X140.023 Y124.069 E.00059
G1 X140.131 Y124.134 E.00073
G1 X140.569 Y124.948 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X140.569 Y128.506 E.10598
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.947 E.10599
G1 X140.978 Y124.995 E.01355
G1 X140.629 Y124.955 E.01048
; WIPE_START
G1 F15000
G1 X140.978 Y124.995 E-.13372
G1 X141.431 Y124.947 E-.17289
G1 X141.431 Y126.141 E-.45339
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F9020
G1 X141 Y125.487 E.09909
; WIPE_START
G1 F12998.803
G1 X141 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.055 Y124.322 Z3.6 F30000
G1 X129.019 Y122.028 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113073
G1 F9020
G1 X128.98 Y121.937 E.00055
G1 X128.887 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.3999
G1 X129.019 Y122.028 E-.3601
; WIPE_END
G1 E-.04 F1800
G1 X127.569 Y121.066 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X127.983 Y121.006 E.01247
G1 X128.431 Y121.036 E.01336
G1 X128.431 Y117.494 E.10551
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.006 E.10462
G1 X128 Y120.575 F30000
; LINE_WIDTH: 0.5276
G1 F9020
G1 X128 Y117.985 E.09918
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.117 Y121.877 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114166
G1 F9020
G1 X127.02 Y121.937 E.00064
G1 X126.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X127.02 Y121.937 E-.35206
G1 X127.117 Y121.877 E-.40794
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y124.036 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.110685
G1 F9020
G1 X127.12 Y124.123 E.00088
; WIPE_START
G1 F15000
G1 X126.981 Y124.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.979 Y124.995 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X127.569 Y124.96 E.01225
G1 X127.569 Y128.506 E.10562
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.947 E.10599
G1 X128.039 Y124.988 E.01175
; WIPE_START
G1 F15000
G1 X128.431 Y124.947 E-.1499
G1 X128.431 Y126.553 E-.6101
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9020
G1 X128 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X128 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.055 Y124.322 Z3.6 F30000
G1 X116.019 Y122.028 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113054
G1 F9020
G1 X115.98 Y121.937 E.00055
G1 X115.887 Y121.879 E.00061
G1 X115.431 Y121.036 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X115.431 Y117.494 E.10551
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.066 E.1064
G3 X115.371 Y121.032 I.481 J1.851 E.02409
G1 X115 Y120.575 F30000
; LINE_WIDTH: 0.5276
G1 F9020
G1 X115 Y117.985 E.09918
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.117 Y121.877 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.114166
G1 F9020
G1 X114.02 Y121.937 E.00064
G1 X113.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.35206
G1 X114.117 Y121.877 E-.40794
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y123.974 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.115636
G1 F9020
G1 X114.023 Y124.069 E.00059
G1 X114.131 Y124.134 E.00073
; WIPE_START
G1 F15000
G1 X114.023 Y124.069 E-.41841
G1 X113.981 Y123.974 E-.34159
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y124.947 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9020
G1 X114.978 Y124.995 E.01355
G1 X114.569 Y124.948 E.01227
G1 X114.569 Y128.506 E.10598
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.007 E.10421
; WIPE_START
G1 F15000
G1 X115.431 Y127.007 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9020
G1 X115 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X115 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.551 Y132.725 Z3.6 F30000
G1 X139.602 Y150.702 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z3.6 F30000
G1 X132.398 Y150.702 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.42 Y147.574 Z3.6 F30000
G1 X119.773 Y144.198 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X119.773 Y135.402 E.28284
G1 X122.227 Y135.402 E.07892
G1 X122.227 Y144.198 E.28284
G1 X119.833 Y144.198 E.07699
M204 S250
G1 X119.381 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X119.381 Y135.01 E.28536
G1 X122.619 Y135.01 E.09646
G1 X122.619 Y144.59 E.28536
G1 X119.441 Y144.59 E.09467
; WIPE_START
G1 F12000
M204 S10000
G1 X119.428 Y142.59 E-.76
; WIPE_END
M73 P83 R2
G1 E-.04 F1800
G1 X121 Y142.971 Z3.6 F30000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.5817
G1 F9020
G1 X121 Y136.689 E.26735
G1 X121.458 Y136.171 F30000
; LINE_WIDTH: 0.41999
G1 F9020
G1 X120.542 Y136.171 E.02728
G1 X120.542 Y143.429 E.21617
G1 X121.458 Y143.429 E.02728
G1 X121.458 Y136.231 E.21439
G1 X121.835 Y135.794 F30000
G1 F9020
G1 X120.165 Y135.794 E.04974
G1 X120.165 Y143.806 E.23864
G1 X121.835 Y143.806 E.04974
G1 X121.835 Y135.854 E.23685
; WIPE_START
G1 F15000
G1 X121.835 Y137.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.86 Y144.883 Z3.6 F30000
G1 X116.398 Y150.702 Z3.6
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9020
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9020
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 17/22
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
G17
G3 Z3.6 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.896 Y113.598
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X119.896 Y104.802 E.28284
G1 X122.104 Y104.802 E.07103
G1 X122.104 Y113.598 E.28284
G1 X119.956 Y113.598 E.0691
M204 S250
G1 X119.503 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X119.503 Y104.41 E.28536
G1 X122.497 Y104.41 E.08915
G1 X122.497 Y113.99 E.28536
G1 X119.563 Y113.99 E.08736
; WIPE_START
G1 F12000
M204 S10000
G1 X119.551 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.712 Y113.206 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X121.712 Y105.194 E.23864
G1 X120.288 Y105.194 E.04244
G1 X120.288 Y113.206 E.23864
G1 X121.652 Y113.206 E.04065
G1 X121.262 Y112.755 F30000
; LINE_WIDTH: 0.56677
G1 F8939
G1 X121.262 Y105.645 E.29425
G1 X120.738 Y105.645 E.02168
G1 X120.738 Y112.755 E.29425
G1 X121.202 Y112.755 E.01919
; WIPE_START
G1 F12026.345
G1 X120.738 Y112.755 E-.17626
G1 X120.738 Y111.219 E-.58374
; WIPE_END
G1 E-.04 F1800
G1 X121.245 Y103.604 Z3.8 F30000
G1 X121.398 Y101.298 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z3.8 F30000
G1 X134.602 Y101.298 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X132.644 Y107.761 Z3.8 F30000
G1 X127.177 Y124.388 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X127.415 Y124.492 E.00833
G2 X128.823 Y124.388 I.593 J-1.556 E.04689
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.448 E.14309
; WIPE_START
G1 F15476.087
G1 X127.415 Y124.492 E-.09178
G1 X127.761 Y124.585 E-.13637
G1 X128.12 Y124.598 E-.13636
G1 X128.472 Y124.531 E-.13631
G1 X128.823 Y124.388 E-.14392
G1 X128.823 Y124.691 E-.11526
; WIPE_END
G1 E-.04 F1800
G1 X126.886 Y122.536 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X126.907 Y122.474 E.00196
G3 X127.823 Y121.803 I1.089 J.526 E.0352
G1 X127.979 Y121.79 E.00465
G3 X126.841 Y122.642 I.018 J1.21 E.18115
G1 X126.862 Y122.591 E.00165
; WIPE_START
G1 F12000
M204 S10000
G1 X126.907 Y122.474 E-.0478
G1 X127.041 Y122.263 E-.09496
G1 X127.177 Y122.113 E-.07686
G1 X127.395 Y121.952 E-.103
G1 X127.643 Y121.844 E-.10298
G1 X127.823 Y121.803 E-.07002
G1 X127.979 Y121.79 E-.05928
G1 X128.18 Y121.803 E-.07683
G1 X128.442 Y121.874 E-.10301
G1 X128.501 Y121.905 E-.02528
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.486 E.05333
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z3.8 F30000
G1 X142.215 Y128.285 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8939
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G2 X140.177 Y121.606 I-.829 J1.541 E.0551
G1 X140.177 Y117.102 E.14482
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09178
G1 X141.357 Y121.438 E-.09095
G1 X140.968 Y121.398 E-.14854
G1 X140.64 Y121.438 E-.12569
G1 X140.177 Y121.606 E-.18689
G1 X140.177 Y121.3 E-.11614
; WIPE_END
G1 E-.04 F1800
G1 X142.189 Y122.794 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X142.203 Y122.91 E.00348
G3 X140.823 Y121.803 I-1.206 J.09 E.16734
G1 X140.979 Y121.79 E.00465
G3 X142.176 Y122.732 I.018 J1.21 E.04907
G1 X142.177 Y122.735 E.00011
; WIPE_START
G1 F12000
M204 S10000
G1 X142.203 Y122.91 E-.06717
G1 X142.197 Y123.18 E-.10285
G1 X142.156 Y123.358 E-.06926
G1 X142.05 Y123.602 E-.1011
G1 X141.946 Y123.754 E-.07005
G1 X141.823 Y123.887 E-.06875
G1 X141.605 Y124.048 E-.103
G1 X141.357 Y124.156 E-.10298
G1 X141.163 Y124.193 E-.07485
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y124.388 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X141.823 Y128.898 E.14502
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G1 X140.415 Y124.492 E.00833
G2 X141.77 Y124.416 I.594 J-1.556 E.04497
; WIPE_START
G1 F15476.087
G1 X141.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.184 Y125.822 Z3.8 F30000
G1 X115.823 Y124.388 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X115.823 Y128.898 E.14502
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G1 X114.415 Y124.492 E.00833
G2 X115.77 Y124.416 I.594 J-1.556 E.04497
; WIPE_START
G1 F15476.087
G1 X115.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.194 Y122.822 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X116.203 Y122.91 E.00262
G3 X114.823 Y121.803 I-1.206 J.09 E.16734
G1 X114.979 Y121.79 E.00465
G3 X116.176 Y122.732 I.018 J1.21 E.04907
G1 X116.182 Y122.763 E.00097
; WIPE_START
G1 F12000
M204 S10000
G1 X116.203 Y122.91 E-.05615
G1 X116.197 Y123.18 E-.10285
G1 X116.156 Y123.358 E-.06926
G1 X116.05 Y123.602 E-.1011
G1 X115.946 Y123.754 E-.07005
G1 X115.823 Y123.887 E-.06875
G1 X115.605 Y124.048 E-.103
G1 X115.357 Y124.156 E-.10298
G1 X115.135 Y124.198 E-.08586
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G2 X114.177 Y121.606 I-.829 J1.541 E.0551
G1 X114.177 Y117.102 E.14482
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09179
G1 X115.357 Y121.438 E-.09093
G1 X114.968 Y121.398 E-.14854
G1 X114.64 Y121.438 E-.12569
G1 X114.177 Y121.606 E-.1869
G1 X114.177 Y121.3 E-.11614
; WIPE_END
G1 E-.04 F1800
G1 X120.853 Y124.999 Z3.8 F30000
G1 X126.785 Y128.285 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z3.8 F30000
G1 X103.215 Y128.285 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8939
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
M73 P84 R2
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z3.8 F30000
G1 X153.79 Y116.71 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8939
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743501
G1 F8939
G1 X153.15 Y117.248 E.00478
; LINE_WIDTH: 0.708445
G1 X153.066 Y117.23 E.00454
; LINE_WIDTH: 0.655997
G1 X152.981 Y117.212 E.00419
G1 X142.019 Y117.212 E.53087
; WIPE_START
G1 F10276.032
G1 X144.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y117.212 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F8939
G1 X129.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y117.212 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X116.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y117.212 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X103.019 Y117.212 E.53075
; LINE_WIDTH: 0.673387
G1 X102.934 Y117.23 E.0043
; LINE_WIDTH: 0.70844
G1 X102.85 Y117.248 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743501
G1 X102.748 Y117.35 E.00478
; LINE_WIDTH: 0.708445
G1 X102.73 Y117.434 E.00454
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.00419
G1 X102.712 Y128.481 E.53088
; LINE_WIDTH: 0.673387
G1 X102.73 Y128.566 E.0043
; LINE_WIDTH: 0.70844
G1 X102.748 Y128.65 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X102.85 Y128.752 E.00478
; LINE_WIDTH: 0.708445
G1 X102.934 Y128.77 E.00454
; LINE_WIDTH: 0.655997
G1 X103.019 Y128.788 E.00419
G1 X113.981 Y128.788 E.53087
; WIPE_START
G1 F10276.032
G1 X111.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y128.788 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F8939
G1 X126.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y128.788 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X139.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y128.788 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X152.981 Y128.788 E.53075
; LINE_WIDTH: 0.673387
G1 X153.066 Y128.77 E.0043
; LINE_WIDTH: 0.70844
G1 X153.15 Y128.752 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X153.252 Y128.65 E.00478
; LINE_WIDTH: 0.708445
G1 X153.27 Y128.566 E.00454
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.00419
G1 X153.288 Y117.519 E.53088
; LINE_WIDTH: 0.673387
G1 X153.27 Y117.434 E.0043
; LINE_WIDTH: 0.70844
G1 X153.252 Y117.35 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 F8992.635
G1 X153.252 Y117.35 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.206 Y120.283 Z3.8 F30000
G1 X142.019 Y122.027 Z3.8
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.113093
G1 F8939
G1 X141.98 Y121.937 E.00054
G1 X141.887 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.40102
G1 X142.019 Y122.027 E-.35898
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.052 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G3 X141.431 Y121.037 I.472 J2.341 E.02581
G1 X141.431 Y117.494 E.10552
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y120.992 E.10419
G1 X141 Y120.575 F30000
; LINE_WIDTH: 0.52758
G1 F8939
G1 X141 Y117.985 E.09915
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.146 Y121.855 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.116997
G1 F8939
G1 X140.026 Y121.925 E.00081
G1 X139.981 Y122.026 E.00065
; WIPE_START
G1 F15000
G1 X140.026 Y121.925 E-.33642
G1 X140.146 Y121.855 E-.42358
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y124.036 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.110961
G1 F8939
G1 X140.12 Y124.123 E.00088
G1 X140.569 Y124.939 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X140.569 Y128.506 E.10624
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.928 E.10658
G1 X141.016 Y124.986 E.01248
G1 X140.629 Y124.945 E.0116
; WIPE_START
G1 F15000
G1 X141.016 Y124.986 E-.148
G1 X141.431 Y124.928 E-.15919
G1 X141.431 Y126.119 E-.45281
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F8939
G1 X141 Y125.477 E.09946
; WIPE_START
G1 F12998.803
G1 X141 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.887 Y124.121 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11306
G1 F8939
G1 X141.98 Y124.063 E.00061
G1 X142.019 Y123.973 E.00055
; WIPE_START
G1 F15000
G1 X141.98 Y124.063 E-.35935
G1 X141.887 Y124.121 E-.40065
; WIPE_END
G1 E-.04 F1800
G1 X134.255 Y124.033 Z3.8 F30000
G1 X129.019 Y123.973 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F8939
G1 X128.98 Y124.063 E.00055
G1 X128.887 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X128.98 Y124.063 E-.40065
G1 X129.019 Y123.973 E-.35935
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y125.188 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X128.431 Y124.928 E.00775
G1 X128.016 Y124.986 E.01248
G1 X127.569 Y124.939 E.01339
G1 X127.569 Y128.506 E.10624
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y125.248 E.09704
; WIPE_START
G1 F15000
G1 X128.431 Y127.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F8939
G1 X128 Y125.477 E.09947
; WIPE_START
G1 F12998.268
G1 X128 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.12 Y124.124 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110972
G1 F8939
G1 X126.981 Y124.036 E.00088
; WIPE_START
G1 F15000
G1 X127.12 Y124.124 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.027 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.113054
G1 F8939
G1 X127.02 Y121.937 E.00054
G1 X127.113 Y121.879 E.00061
G1 X127.569 Y121.067 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X127.989 Y121.006 E.01265
G1 X128.431 Y121.037 E.01318
G1 X128.431 Y117.494 E.10552
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.007 E.10462
G1 X128 Y120.575 F30000
; LINE_WIDTH: 0.5276
G1 F8939
G1 X128 Y117.985 E.09916
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.887 Y121.879 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113093
G1 F8939
G1 X128.98 Y121.937 E.00061
G1 X129.019 Y122.027 E.00054
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.35898
G1 X128.887 Y121.879 E-.40102
; WIPE_END
G1 E-.04 F1800
G1 X121.255 Y121.967 Z3.8 F30000
G1 X116.019 Y122.027 Z3.8
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.113075
G1 F8939
G1 X115.98 Y121.937 E.00054
G1 X115.887 Y121.879 E.00061
G1 X115.431 Y121.037 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X115.431 Y117.494 E.10552
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.052 E.10598
G3 X115.371 Y121.033 I.454 J2.175 E.02402
G1 X115 Y120.575 F30000
; LINE_WIDTH: 0.5276
G1 F8939
G1 X115 Y117.985 E.09915
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.146 Y121.855 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.117016
G1 F8939
G1 X114.026 Y121.925 E.00081
G1 X113.981 Y122.026 E.00065
; WIPE_START
G1 F15000
G1 X114.026 Y121.925 E-.33632
G1 X114.146 Y121.855 E-.42368
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y124.036 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.11098
G1 F8939
G1 X114.12 Y124.124 E.00088
; WIPE_START
G1 F15000
G1 X113.981 Y124.036 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y125.188 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X115.431 Y124.928 E.00775
G1 X115.016 Y124.986 E.01248
G1 X114.569 Y124.939 E.01339
G1 X114.569 Y128.506 E.10624
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.248 E.09704
; WIPE_START
G1 F15000
G1 X115.431 Y127.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F8939
G1 X115 Y125.477 E.09947
; WIPE_START
G1 F12998.268
G1 X115 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.887 Y124.121 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113017
G1 F8939
G1 X115.98 Y124.063 E.00061
G1 X116.019 Y123.974 E.00054
; WIPE_START
G1 F15000
G1 X115.98 Y124.063 E-.35767
G1 X115.887 Y124.121 E-.40233
; WIPE_END
G1 E-.04 F1800
G1 X120.968 Y129.816 Z3.8 F30000
G1 X139.602 Y150.702 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z3.8 F30000
G1 X132.398 Y150.702 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.438 Y147.545 Z3.8 F30000
G1 X119.896 Y144.198 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X119.896 Y135.402 E.28284
G1 X122.104 Y135.402 E.07103
G1 X122.104 Y144.198 E.28284
G1 X119.956 Y144.198 E.0691
M204 S250
G1 X119.503 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X119.503 Y135.01 E.28536
G1 X122.497 Y135.01 E.08915
G1 X122.497 Y144.59 E.28536
M73 P85 R2
G1 X119.563 Y144.59 E.08736
; WIPE_START
G1 F12000
M204 S10000
G1 X119.551 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.712 Y135.794 Z3.8 F30000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8939
G1 X120.288 Y135.794 E.04244
G1 X120.288 Y143.806 E.23864
G1 X121.712 Y143.806 E.04244
G1 X121.712 Y135.854 E.23685
G1 X121.262 Y136.245 F30000
; LINE_WIDTH: 0.56677
G1 F8939
G1 X120.738 Y136.245 E.02168
G1 X120.738 Y143.355 E.29425
G1 X121.262 Y143.355 E.02168
G1 X121.262 Y136.305 E.29177
; WIPE_START
G1 F12026.345
G1 X121.262 Y138.305 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.474 Y145.41 Z3.8 F30000
G1 X116.398 Y150.702 Z3.8
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8939
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8939
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 18/22
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
G17
G3 Z3.8 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X120.018 Y113.598
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X120.018 Y104.802 E.28284
G1 X121.982 Y104.802 E.06315
G1 X121.982 Y113.598 E.28284
G1 X120.078 Y113.598 E.06122
M204 S250
G1 X119.626 Y113.99 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X119.626 Y104.41 E.28536
G1 X122.374 Y104.41 E.08185
G1 X122.374 Y113.99 E.28536
G1 X119.686 Y113.99 E.08006
; WIPE_START
G1 F12000
M204 S10000
G1 X119.674 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.59 Y113.206 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X121.59 Y105.194 E.23864
G1 X120.41 Y105.194 E.03513
G1 X120.41 Y113.206 E.23864
G1 X121.53 Y113.206 E.03335
G1 X121.201 Y112.817 F30000
; LINE_WIDTH: 0.44417
G1 F8783
G1 X121.201 Y105.583 E.22927
G1 X120.799 Y105.583 E.01272
G1 X120.799 Y112.817 E.22927
G1 X121.141 Y112.817 E.01082
; WIPE_START
G1 F15000
G1 X120.799 Y112.817 E-.12968
G1 X120.799 Y111.158 E-.63033
; WIPE_END
G1 E-.04 F1800
G1 X121.262 Y103.54 Z4 F30000
G1 X121.398 Y101.298 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X102.602 Y101.298 E.60441
G1 X102.602 Y100.902 E.01273
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.238 E.0108
M204 S250
G1 X121.79 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X102.21 Y101.69 E.58322
G1 X102.21 Y100.51 E.03515
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.63 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.636 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.462 Z4 F30000
G1 X134.602 Y101.298 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X134.602 Y100.902 E.01273
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.298 E.01273
G1 X134.662 Y101.298 E.60248
M204 S250
G1 X134.21 Y101.69 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X134.21 Y100.51 E.03515
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.69 E.03515
G1 X134.27 Y101.69 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.44898
G1 X135.028 Y100.51 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X132.644 Y107.761 Z4 F30000
G1 X127.177 Y124.388 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X127.415 Y124.492 E.00833
G2 X128.823 Y124.388 I.594 J-1.557 E.04689
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.448 E.14309
; WIPE_START
G1 F15476.087
G1 X127.415 Y124.492 E-.09176
G1 X127.761 Y124.585 E-.1364
G1 X128.12 Y124.598 E-.13637
G1 X128.472 Y124.531 E-.13637
G1 X128.823 Y124.388 E-.14385
G1 X128.823 Y124.691 E-.11526
; WIPE_END
G1 E-.04 F1800
G1 X126.877 Y122.551 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X126.959 Y122.384 E.00554
G3 X127.913 Y121.793 I1.041 J.616 E.03478
G1 X128.086 Y121.793 E.00516
G3 X126.856 Y122.607 I-.087 J1.207 E.17915
; WIPE_START
G1 F12000
M204 S10000
G1 X126.959 Y122.384 E-.09331
G1 X127.113 Y122.177 E-.09809
G1 X127.245 Y122.054 E-.06873
G1 X127.475 Y121.91 E-.10301
G1 X127.731 Y121.82 E-.10293
G1 X127.913 Y121.793 E-.07022
G1 X128.086 Y121.793 E-.06577
G1 X128.269 Y121.82 E-.07025
G1 X128.487 Y121.896 E-.08769
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.498 E.05329
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z4 F30000
G1 X142.215 Y128.285 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8783
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G2 X140.177 Y121.612 I-.823 J1.498 E.05522
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.472 Y121.469 E-.1369
G1 X141.109 Y121.401 E-.14067
G1 X140.891 Y121.401 E-.08252
G1 X140.643 Y121.438 E-.09531
G1 X140.414 Y121.508 E-.091
G1 X140.177 Y121.612 E-.09841
G1 X140.177 Y121.309 E-.11518
; WIPE_END
G1 E-.04 F1800
G1 X142.193 Y122.808 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X142.196 Y122.82 E.00036
G3 X140.913 Y121.793 I-1.196 J.18 E.17261
G1 X141.086 Y121.793 E.00516
G3 X142.126 Y122.558 I-.087 J1.207 E.04056
G1 X142.178 Y122.75 E.00592
; WIPE_START
G1 F12000
M204 S10000
G1 X142.196 Y122.82 E-.02738
G1 X142.21 Y123 E-.06873
G1 X142.18 Y123.269 E-.10299
G1 X142.09 Y123.525 E-.10293
G1 X141.946 Y123.755 E-.10301
G1 X141.823 Y123.887 E-.06874
G1 X141.605 Y124.048 E-.10299
G1 X141.442 Y124.126 E-.06869
G1 X141.18 Y124.197 E-.10298
G1 X141.15 Y124.199 E-.01157
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y124.388 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X141.823 Y128.898 E.14502
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G1 X140.414 Y124.492 E.00833
G2 X141.77 Y124.416 I.594 J-1.556 E.04498
; WIPE_START
G1 F15476.087
G1 X141.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.184 Y125.822 Z4 F30000
G1 X115.823 Y124.388 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8783
G1 X115.823 Y128.898 E.14502
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G1 X114.415 Y124.492 E.00833
G2 X115.77 Y124.416 I.594 J-1.556 E.04497
; WIPE_START
G1 F15476.087
G1 X115.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.198 Y122.838 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X116.21 Y123 E.00483
G3 X114.913 Y121.793 I-1.21 J-.001 E.16722
G1 X115.086 Y121.793 E.00516
G3 X116.189 Y122.779 I-.087 J1.207 E.04743
; WIPE_START
G1 F12000
M204 S10000
G1 X116.21 Y123 E-.08425
G1 X116.18 Y123.269 E-.10298
G1 X116.09 Y123.525 E-.10293
G1 X115.946 Y123.755 E-.10301
G1 X115.823 Y123.887 E-.06874
G1 X115.605 Y124.048 E-.10299
G1 X115.442 Y124.126 E-.06869
G1 X115.18 Y124.197 E-.10298
G1 X115.119 Y124.201 E-.02344
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G2 X114.177 Y121.612 I-.823 J1.498 E.05522
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09176
G1 X115.357 Y121.438 E-.09099
G1 X115.109 Y121.401 E-.09531
G1 X114.891 Y121.401 E-.08252
G1 X114.528 Y121.469 E-.1406
G1 X114.177 Y121.612 E-.1439
G1 X114.177 Y121.309 E-.1149
; WIPE_END
G1 E-.04 F1800
G1 X120.856 Y125.004 Z4 F30000
G1 X126.785 Y128.285 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z4 F30000
G1 X103.215 Y128.285 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8783
M204 S5000
M73 P86 R2
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z4 F30000
G1 X153.79 Y116.71 Z4
G1 Z3.6
G1 E.8 F1800
G1 F8783
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8783
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z4 F30000
G1 Z3.6
G1 E.8 F1800
G1 F8783
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z4 F30000
G1 Z3.6
G1 E.8 F1800
G1 F8783
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F8783
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z4 F30000
G1 Z3.6
G1 E.8 F1800
G1 F8783
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z4 F30000
G1 Z3.6
G1 E.8 F1800
G1 F8783
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F8783
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 F8992.534
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z4 F30000
G1 X142.019 Y122.027 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.113127
G1 F8783
G1 X141.98 Y121.937 E.00055
G1 X141.887 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.40055
G1 X142.019 Y122.027 E-.35945
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.053 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X141.113 Y121.009 E.01624
G1 X141.431 Y121.073 E.00967
G1 X141.431 Y117.494 E.10659
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y120.993 E.10423
G1 X141 Y120.586 F30000
; LINE_WIDTH: 0.52759
G1 F8783
G1 X141 Y117.985 E.09958
; WIPE_START
G1 F12998.535
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.113 Y121.879 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11311
G1 F8783
G1 X140.02 Y121.937 E.00061
G1 X139.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.35945
G1 X140.113 Y121.879 E-.40055
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y123.973 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.113144
G1 F8783
G1 X141.98 Y124.063 E.00055
G1 X141.887 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y124.063 E-.40074
G1 X142.019 Y123.973 E-.35926
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y124.939 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X140.569 Y128.506 E.10624
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.928 E.10658
G1 X141.016 Y124.986 E.01248
G1 X140.629 Y124.945 E.0116
; WIPE_START
G1 F15000
G1 X141.016 Y124.986 E-.148
G1 X141.431 Y124.928 E-.15919
G1 X141.431 Y126.119 E-.45281
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F8783
G1 X141 Y125.477 E.09946
; WIPE_START
G1 F12998.803
G1 X141 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.674 Y125.334 Z4 F30000
G1 X129.019 Y123.973 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113144
G1 F8783
G1 X128.98 Y124.063 E.00055
G1 X128.887 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X128.98 Y124.063 E-.40074
G1 X129.019 Y123.973 E-.35926
; WIPE_END
G1 E-.04 F1800
G1 X128.431 Y125.188 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X128.431 Y124.928 E.00775
G1 X128.016 Y124.986 E.01248
G1 X127.569 Y124.939 E.01339
G1 X127.569 Y128.506 E.10624
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y125.248 E.09704
; WIPE_START
G1 F15000
G1 X128.431 Y127.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F8783
G1 X128 Y125.477 E.09947
; WIPE_START
G1 F12998.268
G1 X128 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y122.027 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113127
G1 F8783
G1 X128.98 Y121.937 E.00055
G1 X128.887 Y121.879 E.00061
G1 X128.431 Y121.073 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X128.431 Y117.494 E.10659
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y121.053 E.10602
G1 X128.113 Y121.009 E.01624
G1 X128.372 Y121.061 E.00788
G1 X128 Y120.586 F30000
; LINE_WIDTH: 0.5276
G1 F8783
G1 X128 Y117.985 E.09958
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.113 Y121.879 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113092
G1 F8783
G1 X127.02 Y121.937 E.00061
G1 X126.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X127.02 Y121.937 E-.35936
G1 X127.113 Y121.879 E-.40064
; WIPE_END
G1 E-.04 F1800
G1 X119.481 Y121.981 Z4 F30000
G1 X116.019 Y122.028 Z4
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.113128
G1 F8783
G1 X115.98 Y121.937 E.00055
G1 X115.887 Y121.879 E.00061
G1 X115.431 Y121.071 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X115.431 Y117.494 E.10655
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.073 E.10659
G1 X115 Y121.009 E.01298
G1 X115.371 Y121.063 E.01118
G1 X115 Y120.578 F30000
; LINE_WIDTH: 0.5276
G1 F8783
G1 X115 Y117.985 E.09927
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.113 Y121.879 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113092
G1 F8783
G1 X114.02 Y121.937 E.00061
G1 X113.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.35936
G1 X114.113 Y121.879 E-.40064
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y123.973 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.113125
G1 F8783
G1 X115.98 Y124.063 E.00055
G1 X115.887 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X115.98 Y124.063 E-.40065
G1 X116.019 Y123.973 E-.35935
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y125.188 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X115.431 Y124.928 E.00775
G1 X115.016 Y124.986 E.01248
G1 X114.569 Y124.939 E.01339
G1 X114.569 Y128.506 E.10624
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.248 E.09704
; WIPE_START
G1 F15000
G1 X115.431 Y127.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F8783
G1 X115 Y125.477 E.09947
; WIPE_START
G1 F12998.268
G1 X115 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.55 Y132.716 Z4 F30000
G1 X139.602 Y150.702 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X153.398 Y150.702 E.44363
G1 X153.398 Y151.098 E.01273
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.762 E.0108
M204 S250
G1 X139.21 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X153.79 Y150.31 E.43429
G1 X153.79 Y151.49 E.03515
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.37 E.03336
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.362 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.656 Z4 F30000
G1 X132.398 Y150.702 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X132.398 Y151.098 E.01273
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.702 E.01273
G1 X132.338 Y150.702 E.28091
M204 S250
G1 X132.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X132.79 Y151.49 E.03515
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.31 E.03515
G1 X132.73 Y150.31 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.44898
G1 X131.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
G1 X125.456 Y147.515 Z4 F30000
G1 X120.018 Y144.198 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X120.018 Y135.402 E.28284
G1 X121.982 Y135.402 E.06315
G1 X121.982 Y144.198 E.28284
G1 X120.078 Y144.198 E.06122
M204 S250
G1 X119.626 Y144.59 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X119.626 Y135.01 E.28536
G1 X122.374 Y135.01 E.08185
G1 X122.374 Y144.59 E.28536
G1 X119.686 Y144.59 E.08006
; WIPE_START
G1 F12000
M204 S10000
M73 P87 R2
G1 X119.674 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.59 Y135.794 Z4 F30000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F8783
G1 X120.41 Y135.794 E.03513
G1 X120.41 Y143.806 E.23864
G1 X121.59 Y143.806 E.03513
G1 X121.59 Y135.854 E.23685
G1 X121.201 Y136.183 F30000
; LINE_WIDTH: 0.44417
G1 F8783
G1 X120.799 Y136.183 E.01272
G1 X120.799 Y143.417 E.22927
G1 X121.201 Y143.417 E.01272
G1 X121.201 Y136.243 E.22737
; WIPE_START
G1 F15000
G1 X121.201 Y138.243 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.455 Y145.365 Z4 F30000
G1 X116.398 Y150.702 Z4
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8783
G1 X116.398 Y151.098 E.01273
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.702 E.01273
G1 X116.338 Y150.702 E.4417
M204 S250
G1 X116.79 Y150.31 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F8783
M204 S5000
G1 X116.79 Y151.49 E.03515
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.31 E.03515
G1 X116.73 Y150.31 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.44898
G1 X115.972 Y151.49 E-.31102
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 19/22
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
G17
G3 Z4 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X119.749 Y113.99
G1 Z3.8
G1 E.8 F1800
G1 F9008
M204 S5000
G1 X119.749 Y104.41 E.28536
G1 X122.251 Y104.41 E.07454
G1 X122.251 Y113.99 E.28536
G1 X119.809 Y113.99 E.07276
; WIPE_START
G1 F12000
M204 S10000
G1 X119.796 Y111.99 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.044 Y105.379 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Top surface
G1 F9008
M204 S2000
G1 X121.282 Y104.617 E.0321
G1 X120.749 Y104.617
G1 X122.044 Y105.913 E.05456
G1 X122.044 Y106.446
G1 X120.215 Y104.617 E.07703
G1 X119.956 Y104.891
G1 X122.044 Y106.979 E.08795
G1 X122.044 Y107.512
G1 X119.956 Y105.425 E.08795
G1 X119.956 Y105.958
G1 X122.044 Y108.046 E.08795
G1 X122.044 Y108.579
G1 X119.956 Y106.491 E.08795
G1 X119.956 Y107.024
G1 X122.044 Y109.112 E.08795
G1 X122.044 Y109.645
G1 X119.956 Y107.558 E.08795
G1 X119.956 Y108.091
G1 X122.044 Y110.179 E.08795
G1 X122.044 Y110.712
G1 X119.956 Y108.624 E.08795
G1 X119.956 Y109.157
G1 X122.044 Y111.245 E.08795
G1 X122.044 Y111.778
M73 P87 R1
G1 X119.956 Y109.691 E.08795
G1 X119.956 Y110.224
G1 X122.044 Y112.312 E.08795
G1 X122.044 Y112.845
G1 X119.956 Y110.757 E.08795
G1 X119.956 Y111.29
G1 X122.044 Y113.378 E.08795
G1 X121.915 Y113.783
G1 X119.956 Y111.824 E.08252
G1 X119.956 Y112.357
G1 X121.382 Y113.783 E.06006
G1 X120.848 Y113.783
G1 X119.956 Y112.89 E.03759
G1 X119.956 Y113.423
G1 X120.315 Y113.783 E.01513
; WIPE_START
G1 F12000
M204 S10000
G1 X119.956 Y113.423 E-.19301
G1 X119.956 Y112.89 E-.20264
G1 X120.634 Y113.568 E-.36436
; WIPE_END
G1 E-.04 F1800
G1 X121.105 Y105.95 Z4.2 F30000
G1 X121.398 Y101.2 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X102.602 Y101.2 E.60441
G1 X102.602 Y100.902 E.00957
G1 X121.398 Y100.902 E.60441
G1 X121.398 Y101.14 E.00764
M204 S250
G1 X121.79 Y101.592 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X102.21 Y101.592 E.58322
G1 X102.21 Y100.51 E.03222
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.532 E.03044
; WIPE_START
G1 F12000
M204 S10000
G1 X119.79 Y101.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.42 Y101.364 Z4.2 F30000
G1 X134.602 Y101.2 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X134.602 Y100.902 E.00957
G1 X153.398 Y100.902 E.60441
G1 X153.398 Y101.2 E.00957
G1 X134.662 Y101.2 E.60248
M204 S250
G1 X134.21 Y101.592 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X134.21 Y100.51 E.03222
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.592 E.03222
G1 X134.27 Y101.592 E.58143
; WIPE_START
G1 F12000
M204 S10000
G1 X134.21 Y100.51 E-.41171
G1 X135.127 Y100.51 E-.34829
; WIPE_END
G1 E-.04 F1800
G1 X133.178 Y107.89 Z4.2 F30000
G1 X128.823 Y124.388 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.416 I.823 J-1.509 E.05326
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.874 Y122.566 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X126.907 Y122.473 E.00295
G3 X127.909 Y121.793 I1.089 J.527 E.03778
G1 X127.991 Y121.79 E.00244
G3 X126.84 Y122.642 I.004 J1.21 E.18073
G1 X126.85 Y122.621 E.0007
; WIPE_START
G1 F12000
M204 S10000
G1 X126.907 Y122.473 E-.06033
G1 X127.054 Y122.245 E-.10287
G1 X127.177 Y122.112 E-.06895
G1 X127.395 Y121.952 E-.10278
G1 X127.635 Y121.846 E-.09968
G1 X127.909 Y121.793 E-.10617
G1 X127.991 Y121.79 E-.03117
G1 X128.18 Y121.803 E-.07194
G1 X128.442 Y121.874 E-.10304
G1 X128.473 Y121.89 E-.01307
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.507 E.05327
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z4.2 F30000
G1 X142.215 Y128.285 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G2 X140.177 Y121.612 I-.823 J1.507 E.05519
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09174
G1 X141.357 Y121.438 E-.09102
G1 X140.99 Y121.398 E-.14013
G1 X140.641 Y121.438 E-.13342
G1 X140.415 Y121.508 E-.09018
G1 X140.177 Y121.612 E-.09844
G1 X140.177 Y121.309 E-.11507
; WIPE_END
G1 E-.04 F1800
G1 X142.19 Y122.822 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X142.202 Y122.91 E.00264
G3 X140.909 Y121.793 I-1.206 J.09 E.16991
G1 X140.991 Y121.79 E.00244
G3 X142.152 Y122.644 I.004 J1.21 E.04597
G1 X142.177 Y122.763 E.00363
; WIPE_START
G1 F12000
M204 S10000
G1 X142.202 Y122.91 E-.05649
G1 X142.207 Y123.091 E-.06892
G1 X142.156 Y123.357 E-.10269
G1 X142.048 Y123.605 E-.10296
G1 X141.946 Y123.755 E-.06882
G1 X141.755 Y123.946 E-.10261
G1 X141.605 Y124.048 E-.06907
G1 X141.357 Y124.156 E-.10295
G1 X141.136 Y124.198 E-.08547
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y124.388 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X141.823 Y128.898 E.14502
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G1 X140.415 Y124.492 E.00833
G2 X141.77 Y124.416 I.594 J-1.556 E.04497
; WIPE_START
G1 F15476.087
G1 X141.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.184 Y125.822 Z4.2 F30000
G1 X115.823 Y124.388 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X115.823 Y128.898 E.14502
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G1 X114.415 Y124.492 E.00833
G2 X115.77 Y124.416 I.593 J-1.556 E.04497
; WIPE_START
G1 F15476.087
G1 X115.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.197 Y122.856 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X116.202 Y122.91 E.00162
G3 X114.909 Y121.793 I-1.206 J.09 E.16991
G1 X114.991 Y121.79 E.00244
G3 X116.152 Y122.644 I.004 J1.21 E.04597
G1 X116.184 Y122.797 E.00466
; WIPE_START
G1 F12000
M204 S10000
G1 X116.202 Y122.91 E-.04339
G1 X116.207 Y123.091 E-.06892
G1 X116.156 Y123.357 E-.10269
G1 X116.048 Y123.605 E-.10296
G1 X115.946 Y123.755 E-.06882
G1 X115.755 Y123.946 E-.10261
G1 X115.605 Y124.048 E-.06907
G1 X115.357 Y124.156 E-.10295
G1 X115.102 Y124.205 E-.09857
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G2 X114.177 Y121.612 I-.823 J1.507 E.05519
M73 P88 R1
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.586 Y121.508 E-.09169
G1 X115.357 Y121.438 E-.09107
G1 X114.99 Y121.398 E-.14013
G1 X114.641 Y121.438 E-.13342
G1 X114.414 Y121.508 E-.0902
G1 X114.177 Y121.612 E-.09842
G1 X114.177 Y121.309 E-.11507
; WIPE_END
G1 E-.04 F1800
G1 X120.855 Y125.004 Z4.2 F30000
G1 X126.785 Y128.285 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z4.2 F30000
G1 X103.215 Y128.285 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z4.2 F30000
G1 X153.79 Y116.71 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743494
G1 F8992.635
G1 X153.252 Y117.35 E.00478
; LINE_WIDTH: 0.70844
G1 F9008
G1 X153.27 Y117.434 E.00454
; LINE_WIDTH: 0.673387
G1 X153.288 Y117.519 E.0043
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.53088
G1 X153.27 Y128.566 E.00419
; LINE_WIDTH: 0.708445
G1 X153.252 Y128.65 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X153.15 Y128.752 E.00478
; LINE_WIDTH: 0.70844
G1 F9008
G1 X153.066 Y128.77 E.00454
; LINE_WIDTH: 0.673387
G1 X152.981 Y128.788 E.0043
; LINE_WIDTH: 0.65586
G1 X142.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X144.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y128.788 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X129.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y128.788 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X116.019 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y128.788 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9008
G1 X103.019 Y128.788 E.53087
G1 X102.934 Y128.77 E.00419
; LINE_WIDTH: 0.708445
G1 X102.85 Y128.752 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743494
G1 X102.748 Y128.65 E.00478
; LINE_WIDTH: 0.70844
G1 F9008
G1 X102.73 Y128.566 E.00454
; LINE_WIDTH: 0.673387
G1 X102.712 Y128.481 E.0043
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.53088
G1 X102.73 Y117.434 E.00419
; LINE_WIDTH: 0.708445
G1 X102.748 Y117.35 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743494
G1 X102.85 Y117.248 E.00478
; LINE_WIDTH: 0.70844
G1 F9008
G1 X102.934 Y117.23 E.00454
; LINE_WIDTH: 0.673387
G1 X103.019 Y117.212 E.0043
; LINE_WIDTH: 0.65586
G1 X113.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X111.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y117.212 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X126.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y117.212 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X139.981 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y117.212 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.655997
G1 F9008
G1 X152.981 Y117.212 E.53087
G1 X153.066 Y117.23 E.00419
; LINE_WIDTH: 0.708445
G1 X153.15 Y117.248 E.00454
; LINE_WIDTH: 0.743501
G1 F8992.534
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 X153.15 Y117.248 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.137 Y120.259 Z4.2 F30000
G1 X142.019 Y122.028 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.112403
G1 F9008
G1 X141.98 Y121.937 E.00054
G1 X141.887 Y121.879 E.0006
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.39972
G1 X142.019 Y122.028 E-.36028
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.053 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G3 X141.431 Y121.039 I.468 J2.304 E.02582
G1 X141.431 Y117.494 E.10558
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y120.993 E.1042
G1 X141 Y120.574 F30000
; LINE_WIDTH: 0.52758
G1 F9008
G1 X141 Y117.985 E.09911
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.115 Y121.878 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11355
G1 F9008
G1 X140.02 Y121.937 E.00062
G1 X139.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.35523
G1 X140.115 Y121.878 E-.40477
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y123.973 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.1124
G1 F9008
G1 X140.02 Y124.063 E.00054
G1 X140.113 Y124.121 E.0006
G1 X140.569 Y124.939 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G1 X140.569 Y128.506 E.10624
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.928 E.10657
G1 X141.016 Y124.986 E.01248
G1 X140.629 Y124.945 E.01159
; WIPE_START
G1 F15000
G1 X141.016 Y124.986 E-.14792
G1 X141.431 Y124.928 E-.15925
G1 X141.431 Y126.12 E-.45283
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F9008
G1 X141 Y125.477 E.09947
; WIPE_START
G1 F12998.803
G1 X141 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.887 Y124.121 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109875
G1 F9008
G1 X141.979 Y124.063 E.00058
G1 X142.019 Y123.972 E.00052
; WIPE_START
G1 F15000
G1 X141.979 Y124.063 E-.36001
G1 X141.887 Y124.121 E-.39999
; WIPE_END
G1 E-.04 F1800
G1 X134.255 Y124.033 Z4.2 F30000
G1 X129.019 Y123.972 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
G1 X128.979 Y124.063 E.00052
G1 X128.887 Y124.121 E.00058
; WIPE_START
G1 F15000
G1 X128.979 Y124.063 E-.39999
G1 X129.019 Y123.972 E-.36001
; WIPE_END
G1 E-.04 F1800
G1 X127.979 Y124.995 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G1 X127.569 Y124.96 E.01225
G1 X127.569 Y128.506 E.10562
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.947 E.10599
G1 X128.039 Y124.988 E.01175
; WIPE_START
G1 F15000
G1 X128.431 Y124.947 E-.14988
G1 X128.431 Y126.553 E-.61012
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9008
G1 X128 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X128 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.113 Y124.121 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112448
G1 F9008
G1 X127.02 Y124.063 E.0006
G1 X126.981 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X127.02 Y124.063 E-.35939
G1 X127.113 Y124.121 E-.40061
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.027 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.113573
G1 F9008
G1 X127.02 Y121.937 E.00055
G1 X127.115 Y121.878 E.00062
G1 X127.569 Y121.053 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G3 X128.431 Y121.039 I.468 J2.303 E.02582
G1 X128.431 Y117.494 E.10558
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y120.993 E.1042
G1 X128 Y120.574 F30000
; LINE_WIDTH: 0.5276
G1 F9008
G1 X128 Y117.985 E.09911
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.887 Y121.879 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112403
G1 F9008
G1 X128.98 Y121.937 E.0006
G1 X129.019 Y122.028 E.00054
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.36028
G1 X128.887 Y121.879 E-.39972
; WIPE_END
G1 E-.04 F1800
G1 X121.255 Y121.967 Z4.2 F30000
G1 X116.019 Y122.028 Z4.2
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.112384
G1 F9008
G1 X115.98 Y121.937 E.00054
G1 X115.887 Y121.879 E.0006
G1 X115.431 Y121.039 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G1 X115.431 Y117.494 E.10558
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.053 E.10599
G3 X115.371 Y121.034 I.451 J2.141 E.02403
G1 X115 Y120.574 F30000
; LINE_WIDTH: 0.5276
G1 F9008
G1 X115 Y117.985 E.09912
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.115 Y121.878 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113577
G1 F9008
G1 X114.02 Y121.937 E.00062
G1 X113.981 Y122.027 E.00055
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.35638
G1 X114.115 Y121.878 E-.40362
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y123.973 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.11242
G1 F9008
G1 X114.02 Y124.063 E.00054
G1 X114.113 Y124.121 E.0006
; WIPE_START
G1 F15000
G1 X114.02 Y124.063 E-.4004
G1 X113.981 Y123.973 E-.3596
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y125.186 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9008
G1 X115.431 Y124.928 E.00767
G1 X115.016 Y124.986 E.01248
G1 X114.569 Y124.939 E.01338
G1 X114.569 Y128.506 E.10624
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.246 E.09711
; WIPE_START
G1 F15000
G1 X115.431 Y127.246 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F9008
G1 X115 Y125.477 E.09947
; WIPE_START
G1 F12998.268
G1 X115 Y127.477 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.887 Y124.121 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109874
G1 F9008
G1 X115.979 Y124.063 E.00058
G1 X116.019 Y123.972 E.00052
; WIPE_START
G1 F15000
G1 X115.979 Y124.063 E-.35996
G1 X115.887 Y124.121 E-.40004
; WIPE_END
G1 E-.04 F1800
G1 X120.958 Y129.826 Z4.2 F30000
G1 X139.602 Y150.8 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X153.398 Y150.8 E.44363
G1 X153.398 Y151.098 E.00957
G1 X139.602 Y151.098 E.44363
G1 X139.602 Y150.86 E.00764
M204 S250
G1 X139.21 Y150.408 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X153.79 Y150.408 E.43429
G1 X153.79 Y151.49 E.03222
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.468 E.03044
; WIPE_START
G1 F12000
M204 S10000
G1 X141.21 Y150.46 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.583 Y150.755 Z4.2 F30000
M73 P89 R1
G1 X132.398 Y150.8 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X132.398 Y151.098 E.00957
G1 X123.602 Y151.098 E.28284
G1 X123.602 Y150.8 E.00957
G1 X132.338 Y150.8 E.28091
M204 S250
G1 X132.79 Y150.408 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X132.79 Y151.49 E.03222
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.408 E.03222
G1 X132.73 Y150.408 E.28357
; WIPE_START
G1 F12000
M204 S10000
G1 X132.79 Y151.49 E-.41171
G1 X131.873 Y151.49 E-.34829
; WIPE_END
G1 E-.04 F1800
G1 X125.24 Y147.715 Z4.2 F30000
G1 X119.749 Y144.59 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F9008
M204 S5000
G1 X119.749 Y135.01 E.28536
G1 X122.251 Y135.01 E.07454
G1 X122.251 Y144.59 E.28536
G1 X119.809 Y144.59 E.07276
; WIPE_START
G1 F12000
M204 S10000
G1 X119.796 Y142.59 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.486 Y135.217 Z4.2 F30000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Top surface
G1 F9008
M204 S2000
G1 X122.044 Y135.775 E.02349
G1 X122.044 Y136.308
G1 X120.953 Y135.217 E.04596
G1 X120.42 Y135.217
G1 X122.044 Y136.842 E.06842
G1 X122.044 Y137.375
G1 X119.956 Y135.287 E.08795
G1 X119.956 Y135.82
G1 X122.044 Y137.908 E.08795
G1 X122.044 Y138.441
G1 X119.956 Y136.354 E.08795
G1 X119.956 Y136.887
G1 X122.044 Y138.975 E.08795
G1 X122.044 Y139.508
G1 X119.956 Y137.42 E.08795
G1 X119.956 Y137.953
G1 X122.044 Y140.041 E.08795
G1 X122.044 Y140.574
G1 X119.956 Y138.487 E.08795
G1 X119.956 Y139.02
G1 X122.044 Y141.108 E.08795
G1 X122.044 Y141.641
G1 X119.956 Y139.553 E.08795
G1 X119.956 Y140.086
G1 X122.044 Y142.174 E.08795
G1 X122.044 Y142.707
G1 X119.956 Y140.62 E.08795
G1 X119.956 Y141.153
G1 X122.044 Y143.241 E.08795
G1 X122.044 Y143.774
G1 X119.956 Y141.686 E.08795
G1 X119.956 Y142.219
G1 X122.044 Y144.307 E.08795
G1 X121.586 Y144.383
G1 X119.956 Y142.753 E.06866
G1 X119.956 Y143.286
G1 X121.053 Y144.383 E.0462
G1 X120.52 Y144.383
G1 X119.956 Y143.819 E.02374
; WIPE_START
G1 F12000
M204 S10000
G1 X120.52 Y144.383 E-.30281
G1 X121.053 Y144.383 E-.20264
G1 X120.579 Y143.909 E-.25455
; WIPE_END
G1 E-.04 F1800
G1 X116.62 Y150.434 Z4.2 F30000
G1 X116.398 Y150.8 Z4.2
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F9008
G1 X116.398 Y151.098 E.00957
G1 X102.602 Y151.098 E.44363
G1 X102.602 Y150.8 E.00957
G1 X116.338 Y150.8 E.4417
M204 S250
G1 X116.79 Y150.408 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9008
M204 S5000
G1 X116.79 Y151.49 E.03222
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.408 E.03222
G1 X116.73 Y150.408 E.4325
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12000
M204 S10000
G1 X116.79 Y151.49 E-.41171
G1 X115.873 Y151.49 E-.34829
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 20/22
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
G17
G3 Z4.2 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X121.79 Y101.395
G1 Z4
G1 E.8 F1800
G1 F6830
M204 S5000
G1 X102.21 Y101.395 E.58322
G1 X102.21 Y100.51 E.02636
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.335 E.02457
M204 S10000
G1 X121.594 Y100.952 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.53586
G1 F6830
G1 X102.406 Y100.952 E.74715
; WIPE_START
G1 F12780.46
G1 X104.406 Y100.952 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.038 Y101.066 Z4.4 F30000
G1 X134.21 Y101.395 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X134.21 Y100.51 E.02636
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.395 E.02636
G1 X134.27 Y101.395 E.58143
M204 S10000
G1 X134.406 Y100.952 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.53586
G1 F6830
G1 X153.594 Y100.952 E.74715
; WIPE_START
G1 F12780.46
G1 X151.594 Y100.952 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.275 Y106.426 Z4.4 F30000
G1 X128.823 Y124.388 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6830
G1 X128.823 Y128.898 E.14502
G1 X127.177 Y128.898 E.05293
G1 X127.177 Y124.388 E.14502
G2 X128.77 Y124.416 I.823 J-1.508 E.05326
; WIPE_START
G1 F15476.087
G1 X128.794 Y126.416 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.873 Y122.577 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X126.95 Y122.394 E.00591
G3 X127.909 Y121.793 I1.047 J.606 E.03508
G1 X127.996 Y121.79 E.00257
G3 X126.842 Y122.643 I.002 J1.21 E.18064
G1 X126.847 Y122.631 E.00039
; WIPE_START
G1 F12000
M204 S10000
G1 X126.95 Y122.394 E-.09819
G1 X127.054 Y122.245 E-.06896
G1 X127.246 Y122.054 E-.10285
G1 X127.395 Y121.952 E-.06873
G1 X127.643 Y121.844 E-.10278
G1 X127.909 Y121.793 E-.10311
G1 X127.996 Y121.79 E-.03281
G1 X128.18 Y121.803 E-.07028
G1 X128.442 Y121.873 E-.10301
G1 X128.464 Y121.884 E-.00928
; WIPE_END
G1 E-.04 F1800
G1 X127.177 Y121.612 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6830
G1 X127.177 Y117.102 E.14502
G1 X128.823 Y117.102 E.05293
G1 X128.823 Y121.612 E.14502
G2 X127.23 Y121.584 I-.823 J1.507 E.05327
; WIPE_START
G1 F15476.087
G1 X127.206 Y119.584 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.215 Y117.715 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X139.785 Y117.715 E.31484
G1 X139.785 Y128.285 E.31484
G1 X129.215 Y128.285 E.31484
G1 X129.215 Y117.775 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X131.215 Y117.764 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.731 Y123.039 Z4.4 F30000
G1 X142.215 Y128.285 Z4.4
G1 Z4
G1 E.8 F1800
G1 F6830
M204 S5000
G1 X142.215 Y117.715 E.31484
G1 X152.785 Y117.715 E.31484
G1 X152.785 Y128.285 E.31484
G1 X142.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X142.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y121.612 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6830
G2 X140.177 Y121.612 I-.823 J1.507 E.05519
G1 X140.177 Y117.102 E.14502
G1 X141.823 Y117.102 E.05293
G1 X141.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X141.585 Y121.508 E-.09179
G1 X141.356 Y121.438 E-.09103
G1 X140.995 Y121.398 E-.13816
G1 X140.643 Y121.438 E-.1346
G1 X140.41 Y121.51 E-.09277
G1 X140.177 Y121.612 E-.09659
G1 X140.177 Y121.309 E-.11506
; WIPE_END
G1 E-.04 F1800
G1 X142.191 Y122.834 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X142.207 Y123 E.00495
G3 X140.909 Y121.793 I-1.21 J0 E.16717
G1 X140.996 Y121.79 E.00257
G3 X142.177 Y122.731 I.002 J1.21 E.04859
G1 X142.183 Y122.775 E.00131
; WIPE_START
G1 F12000
M204 S10000
G1 X142.207 Y123 E-.08597
G1 X142.197 Y123.18 E-.06871
G1 X142.126 Y123.442 E-.10299
G1 X142 Y123.681 E-.10281
G1 X141.826 Y123.884 E-.10143
G1 X141.682 Y124 E-.07038
G1 X141.442 Y124.126 E-.10298
G1 X141.185 Y124.196 E-.10136
G1 X141.123 Y124.201 E-.02338
; WIPE_END
G1 E-.04 F1800
G1 X141.823 Y128.285 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6830
G1 X141.823 Y128.898 E.01971
G1 X140.177 Y128.898 E.05293
G1 X140.177 Y124.388 E.14502
G2 X141.823 Y124.388 I.823 J-1.508 E.05519
G1 X141.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X141.823 Y128.898 E-.25572
G1 X140.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X132.866 Y128.708 Z4.4 F30000
G1 X115.823 Y128.285 Z4.4
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X115.823 Y128.898 E.01971
G1 X114.177 Y128.898 E.05293
G1 X114.177 Y124.388 E.14502
G2 X115.823 Y124.388 I.823 J-1.508 E.05519
G1 X115.823 Y128.225 E.12338
; WIPE_START
G1 F15476.087
G1 X115.823 Y128.898 E-.25572
G1 X114.496 Y128.898 E-.50428
; WIPE_END
G1 E-.04 F1800
G1 X116.196 Y122.871 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X116.207 Y123 E.00384
G3 X114.909 Y121.793 I-1.21 J0 E.16717
G1 X114.996 Y121.79 E.00257
G3 X116.177 Y122.731 I.002 J1.21 E.04859
G1 X116.188 Y122.812 E.00242
; WIPE_START
G1 F12000
M204 S10000
G1 X116.207 Y123 E-.07181
G1 X116.197 Y123.18 E-.06871
G1 X116.126 Y123.442 E-.10299
G1 X116 Y123.681 E-.10281
G1 X115.826 Y123.884 E-.10143
G1 X115.682 Y124 E-.07038
G1 X115.442 Y124.126 E-.10298
G1 X115.185 Y124.196 E-.10136
G1 X115.086 Y124.203 E-.03753
; WIPE_END
G1 E-.04 F1800
G1 X115.823 Y121.612 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P90 R1
G1 F6830
G2 X114.177 Y121.612 I-.823 J1.507 E.05519
G1 X114.177 Y117.102 E.14502
G1 X115.823 Y117.102 E.05293
G1 X115.823 Y121.552 E.14309
; WIPE_START
G1 F15476.087
G1 X115.585 Y121.508 E-.09181
G1 X115.356 Y121.438 E-.09101
G1 X114.995 Y121.398 E-.13816
G1 X114.643 Y121.438 E-.1346
G1 X114.41 Y121.51 E-.09277
G1 X114.177 Y121.612 E-.0966
G1 X114.177 Y121.309 E-.11506
; WIPE_END
G1 E-.04 F1800
G1 X120.855 Y125.004 Z4.4 F30000
G1 X126.785 Y128.285 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X116.215 Y128.285 E.31484
G1 X116.215 Y117.715 E.31484
G1 X126.785 Y117.715 E.31484
G1 X126.785 Y128.225 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X124.785 Y128.236 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.153 Y128.254 Z4.4 F30000
G1 X103.215 Y128.285 Z4.4
G1 Z4
G1 E.8 F1800
G1 F6830
M204 S5000
G1 X103.215 Y117.715 E.31484
G1 X113.785 Y117.715 E.31484
G1 X113.785 Y128.285 E.31484
G1 X103.275 Y128.285 E.31306
; WIPE_START
G1 F12000
M204 S10000
G1 X103.264 Y126.285 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.763 Y124.864 Z4.4 F30000
G1 X153.79 Y116.71 Z4.4
G1 Z4
G1 E.8 F1800
G1 F6830
M204 S5000
G1 X153.79 Y129.29 E.37472
G1 X102.21 Y129.29 E1.53639
G1 X102.21 Y116.71 E.37472
G1 X153.73 Y116.71 E1.53461
M204 S10000
G1 X153.235 Y117.265 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.743501
G1 F6830
G1 X153.15 Y117.248 E.00478
; LINE_WIDTH: 0.708445
G1 X153.066 Y117.23 E.00454
; LINE_WIDTH: 0.655997
G1 X152.981 Y117.212 E.00419
G1 X142.019 Y117.212 E.53087
; WIPE_START
G1 F10276.032
G1 X144.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y117.212 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F6830
G1 X129.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X131.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y117.212 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X116.019 Y117.212 E.53075
; WIPE_START
G1 F10278.331
G1 X118.019 Y117.212 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y117.212 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X103.019 Y117.212 E.53075
; LINE_WIDTH: 0.673387
G1 X102.934 Y117.23 E.0043
; LINE_WIDTH: 0.70844
G1 X102.85 Y117.248 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y117.265 E.00478
; LINE_WIDTH: 0.743501
G1 X102.748 Y117.35 E.00478
; LINE_WIDTH: 0.708445
G1 X102.73 Y117.434 E.00454
; LINE_WIDTH: 0.655997
G1 X102.712 Y117.519 E.00419
G1 X102.712 Y128.481 E.53088
; LINE_WIDTH: 0.673387
G1 X102.73 Y128.566 E.0043
; LINE_WIDTH: 0.70844
G1 X102.748 Y128.65 E.00454
; LINE_WIDTH: 0.743494
G1 X102.765 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X102.85 Y128.752 E.00478
; LINE_WIDTH: 0.708445
G1 X102.934 Y128.77 E.00454
; LINE_WIDTH: 0.655997
G1 X103.019 Y128.788 E.00419
G1 X113.981 Y128.788 E.53087
; WIPE_START
G1 F10276.032
G1 X111.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.019 Y128.788 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.65586
G1 F6830
G1 X126.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X124.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.019 Y128.788 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X139.981 Y128.788 E.53075
; WIPE_START
G1 F10278.331
G1 X137.981 Y128.788 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X142.019 Y128.788 Z4.4 F30000
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X152.981 Y128.788 E.53075
; LINE_WIDTH: 0.673387
G1 X153.066 Y128.77 E.0043
; LINE_WIDTH: 0.70844
G1 X153.15 Y128.752 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y128.735 E.00478
; LINE_WIDTH: 0.743501
G1 X153.252 Y128.65 E.00478
; LINE_WIDTH: 0.708445
G1 X153.27 Y128.566 E.00454
; LINE_WIDTH: 0.655997
G1 X153.288 Y128.481 E.00419
G1 X153.288 Y117.519 E.53088
; LINE_WIDTH: 0.673387
G1 X153.27 Y117.434 E.0043
; LINE_WIDTH: 0.70844
G1 X153.252 Y117.35 E.00454
; LINE_WIDTH: 0.743494
G1 X153.235 Y117.265 E.00478
; WIPE_START
G1 F8992.635
G1 X153.252 Y117.35 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X146.206 Y120.283 Z4.4 F30000
G1 X142.019 Y122.026 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.112977
G1 F6830
G1 X141.98 Y121.937 E.00054
G1 X141.886 Y121.879 E.00061
; WIPE_START
G1 F15000
G1 X141.98 Y121.937 E-.40342
G1 X142.019 Y122.026 E-.35658
; WIPE_END
G1 E-.04 F1800
G1 X140.569 Y121.053 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G3 X141.431 Y121.039 I.467 J2.286 E.02582
G1 X141.431 Y117.494 E.10559
G1 X140.569 Y117.494 E.02567
G1 X140.569 Y120.993 E.1042
G1 X141 Y120.574 F30000
; LINE_WIDTH: 0.52758
G1 F6830
G1 X141 Y117.985 E.0991
; WIPE_START
G1 F12998.803
G1 X141 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.113 Y121.879 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113029
G1 F6830
G1 X140.02 Y121.937 E.00061
G1 X139.981 Y122.028 E.00055
; WIPE_START
G1 F15000
G1 X140.02 Y121.937 E-.36012
G1 X140.113 Y121.879 E-.39988
; WIPE_END
G1 E-.04 F1800
G1 X139.981 Y123.973 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.113315
G1 F6830
G1 X140.02 Y124.063 E.00054
G1 X140.114 Y124.121 E.00061
G1 X140.569 Y124.96 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G1 X140.569 Y128.506 E.10561
G1 X141.431 Y128.506 E.02567
G1 X141.431 Y124.947 E.10599
G1 X140.979 Y124.995 E.01353
G1 X140.629 Y124.965 E.01046
; WIPE_START
G1 F15000
G1 X140.979 Y124.995 E-.13349
G1 X141.431 Y124.947 E-.17266
G1 X141.431 Y126.142 E-.45385
; WIPE_END
G1 E-.04 F1800
G1 X141 Y128.075 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.52758
G1 F6830
G1 X141 Y125.487 E.09909
; WIPE_START
G1 F12998.803
G1 X141 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X141.887 Y124.121 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.111371
G1 F6830
G1 X141.98 Y124.063 E.00059
G1 X142.019 Y123.972 E.00053
; WIPE_START
G1 F15000
G1 X141.98 Y124.063 E-.36034
G1 X141.887 Y124.121 E-.39966
; WIPE_END
G1 E-.04 F1800
G1 X134.255 Y124.033 Z4.4 F30000
G1 X129.019 Y123.972 Z4.4
G1 Z4
G1 E.8 F1800
G1 F6830
G1 X128.98 Y124.063 E.00053
G1 X128.887 Y124.121 E.00059
; WIPE_START
G1 F15000
G1 X128.98 Y124.063 E-.39966
G1 X129.019 Y123.972 E-.36034
; WIPE_END
G1 E-.04 F1800
G1 X127.979 Y124.995 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G1 X127.569 Y124.96 E.01225
G1 X127.569 Y128.506 E.10561
G1 X128.431 Y128.506 E.02567
G1 X128.431 Y124.947 E.10599
G1 X128.039 Y124.988 E.01175
; WIPE_START
G1 F15000
G1 X128.431 Y124.947 E-.14986
G1 X128.431 Y126.553 E-.61014
; WIPE_END
G1 E-.04 F1800
G1 X128 Y128.075 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F6830
G1 X128 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X128 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.114 Y124.121 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113326
G1 F6830
G1 X127.02 Y124.063 E.00061
G1 X126.981 Y123.973 E.00054
; WIPE_START
G1 F15000
G1 X127.02 Y124.063 E-.35721
G1 X127.114 Y124.121 E-.40279
; WIPE_END
G1 E-.04 F1800
G1 X126.981 Y122.028 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.113048
G1 F6830
G1 X127.02 Y121.937 E.00055
G1 X127.113 Y121.879 E.00061
G1 X127.569 Y121.053 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G3 X128.431 Y121.039 I.467 J2.285 E.02582
G1 X128.431 Y117.494 E.10559
G1 X127.569 Y117.494 E.02567
G1 X127.569 Y120.993 E.1042
G1 X128 Y120.574 F30000
; LINE_WIDTH: 0.5276
G1 F6830
G1 X128 Y117.985 E.09911
; WIPE_START
G1 F12998.268
G1 X128 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.886 Y121.879 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112977
G1 F6830
G1 X128.98 Y121.937 E.00061
G1 X129.019 Y122.026 E.00054
; WIPE_START
G1 F15000
G1 X128.98 Y121.937 E-.35658
G1 X128.886 Y121.879 E-.40342
; WIPE_END
G1 E-.04 F1800
G1 X121.254 Y121.967 Z4.4 F30000
G1 X116.019 Y122.027 Z4.4
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.112966
G1 F6830
G1 X115.98 Y121.937 E.00054
G1 X115.886 Y121.879 E.00061
G1 X115.431 Y121.039 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G1 X115.431 Y117.494 E.10559
G1 X114.569 Y117.494 E.02567
G1 X114.569 Y121.053 E.10599
G3 X115.371 Y121.034 I.45 J2.124 E.02403
G1 X115 Y120.574 F30000
; LINE_WIDTH: 0.5276
G1 F6830
G1 X115 Y117.985 E.09911
; WIPE_START
G1 F12998.268
G1 X115 Y119.985 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.113 Y121.879 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11304
G1 F6830
G1 X114.02 Y121.937 E.00061
G1 X113.981 Y122.028 E.00055
; WIPE_START
G1 F15000
G1 X114.02 Y121.937 E-.36014
G1 X114.113 Y121.879 E-.39986
; WIPE_END
G1 E-.04 F1800
G1 X113.981 Y123.973 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.113325
G1 F6830
G1 X114.02 Y124.063 E.00054
G1 X114.114 Y124.121 E.00061
; WIPE_START
G1 F15000
G1 X114.02 Y124.063 E-.40283
G1 X113.981 Y123.973 E-.35717
; WIPE_END
G1 E-.04 F1800
G1 X115.431 Y124.947 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6830
G3 X114.569 Y124.96 I-.464 J-2.255 E.02582
G1 X114.569 Y128.506 E.10561
G1 X115.431 Y128.506 E.02567
G1 X115.431 Y125.007 E.10421
; WIPE_START
G1 F15000
G1 X115.431 Y127.007 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115 Y128.075 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; LINE_WIDTH: 0.5276
G1 F6830
G1 X115 Y125.487 E.0991
; WIPE_START
G1 F12998.268
G1 X115 Y127.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.887 Y124.121 Z4.4 F30000
G1 Z4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.111354
G1 F6830
G1 X115.98 Y124.063 E.00059
G1 X116.019 Y123.972 E.00053
; WIPE_START
G1 F15000
G1 X115.98 Y124.063 E-.36042
G1 X115.887 Y124.121 E-.39958
; WIPE_END
G1 E-.04 F1800
G1 X120.931 Y129.849 Z4.4 F30000
G1 X139.21 Y150.605 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P91 R1
G1 F6830
M204 S5000
G1 X153.79 Y150.605 E.43429
G1 X153.79 Y151.49 E.02636
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.665 E.02457
M204 S10000
G1 X139.406 Y151.048 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.53586
G1 F6830
G1 X153.594 Y151.048 E.55246
; WIPE_START
G1 F12780.46
G1 X151.594 Y151.048 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.964 Y150.868 Z4.4 F30000
G1 X132.79 Y150.605 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X132.79 Y151.49 E.02636
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.605 E.02636
G1 X132.73 Y150.605 E.28357
M204 S10000
G1 X132.594 Y151.048 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.53586
G1 F6830
G1 X123.406 Y151.048 E.35777
; WIPE_START
G1 F12780.46
G1 X125.406 Y151.048 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.784 Y150.656 Z4.4 F30000
G1 X116.79 Y150.605 Z4.4
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6830
M204 S5000
G1 X116.79 Y151.49 E.02636
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.605 E.02636
G1 X116.73 Y150.605 E.4325
M204 S10000
G1 X116.594 Y151.048 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.53586
G1 F6830
G1 X102.406 Y151.048 E.55246
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F12780.46
G1 X104.406 Y151.048 E-.76
; WIPE_END
G1 E-.04 F1800
; PAUSE: drop the four magnets into the pockets (same way up), then resume
G1 Z14 F1200
M400 U1
; layer num/total_layer_count: 21/22
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
M106 S51
G17
G3 Z4.4 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X121.79 Y101.198
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X102.21 Y101.198 E.58322
G1 X102.21 Y100.51 E.0205
G1 X121.79 Y100.51 E.58322
G1 X121.79 Y101.138 E.01871
M204 S10000
G1 X121.594 Y100.854 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.33909
G1 F15000
G1 X102.406 Y100.854 E.44891
; WIPE_START
G1 X104.406 Y100.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.038 Y100.942 Z4.6 F30000
G1 X134.21 Y101.198 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X134.21 Y100.51 E.0205
G1 X153.79 Y100.51 E.58322
G1 X153.79 Y101.198 E.0205
G1 X134.27 Y101.198 E.58143
M204 S10000
G1 X134.406 Y100.854 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.33909
G1 F15000
G1 X153.594 Y100.854 E.44891
; WIPE_START
G1 X151.594 Y100.854 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X145.809 Y105.833 Z4.6 F30000
G1 X126.495 Y122.453 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M106 S255
G1 F840
G1 X126.508 Y122.415 E.00133
M106 S51
M106 S255
G1 F1440
G1 X126.556 Y122.305 E.00386
M106 S51
M106 S255
G1 F2040
G1 X126.612 Y122.199 E.00385
M106 S51
M106 S255
G1 F2880
G1 X126.676 Y122.097 E.00386
M106 S51
M106 S255
G1 F4229.231
G1 X126.747 Y122.001 E.00385
M106 S51
G1 F4427.574
G1 X126.757 Y121.989 E.00051
G1 F9814.129
G1 X127.001 Y121.747 E.01103
G1 F15476.087
G1 X127.305 Y121.557 E.01154
G3 X127.88 Y121.402 I.7 J1.452 E.01926
G3 X128.585 Y121.509 I.116 J1.605 E.02312
G1 X128.903 Y121.676 E.01153
G1 F12204.888
G1 X129.09 Y121.825 E.0077
G1 F7701.019
G1 X129.242 Y121.989 E.00719
G1 F4427.574
G1 X129.253 Y122.001 E.00051
M106 S255
G1 F4229.231
G1 X129.324 Y122.097 E.00385
M106 S51
M106 S255
G1 F2880
G1 X129.388 Y122.199 E.00386
M106 S51
M106 S255
G1 F2040
G1 X129.444 Y122.305 E.00385
M106 S51
M106 S255
G1 F1440
G1 X129.492 Y122.415 E.00386
M106 S51
M106 S255
G1 F840
G1 X129.531 Y122.528 E.00386
M106 S51
M106 S255
G1 F600
G1 X129.562 Y122.643 E.00385
M106 S51
M106 S255
G1 X129.585 Y122.761 E.00385
M106 S51
M106 S255
G1 X129.598 Y122.88 E.00385
M106 S51
M106 S255
G3 X129.598 Y123.12 I-1.609 J.12 E.00772
M106 S51
M106 S255
G1 X129.585 Y123.239 E.00385
M106 S51
M106 S255
G1 X129.562 Y123.357 E.00385
M106 S51
M106 S255
G1 X129.531 Y123.472 E.00385
M106 S51
M106 S255
G1 F840
G1 X129.492 Y123.585 E.00386
M106 S51
M106 S255
G1 F1440
G1 X129.444 Y123.695 E.00385
M106 S51
M106 S255
G1 F2040
G1 X129.388 Y123.801 E.00386
M106 S51
M106 S255
G1 F2880
G1 X129.324 Y123.903 E.00385
M106 S51
M106 S255
G1 F4231.501
G1 X129.253 Y123.999 E.00386
M106 S51
G1 F4429.458
G1 X129.242 Y124.011 E.00051
G1 F9817.198
G1 X128.999 Y124.253 E.01103
G1 F15476.087
G1 X128.694 Y124.441 E.01153
G3 X127.306 Y124.441 I-.694 J-1.451 E.04614
G1 X127.001 Y124.253 E.01153
G1 F9817.863
G1 X126.757 Y124.011 E.01103
G1 F4429.458
G1 X126.747 Y123.999 E.00051
M106 S255
G1 F4231.501
G1 X126.676 Y123.903 E.00386
M106 S51
M106 S255
G1 F2880
G1 X126.612 Y123.801 E.00385
M106 S51
M106 S255
G1 F2040
G1 X126.556 Y123.695 E.00386
M106 S51
M106 S255
G1 F1440
G1 X126.508 Y123.585 E.00385
M106 S51
M106 S255
G1 F840
G1 X126.469 Y123.472 E.00386
M106 S51
M106 S255
G1 F600
G1 X126.438 Y123.357 E.00385
M106 S51
M106 S255
G1 X126.415 Y123.239 E.00385
M106 S51
M106 S255
G1 X126.402 Y123.12 E.00385
M106 S51
M106 S255
G3 X126.402 Y122.88 I1.609 J-.12 E.00772
M106 S51
M106 S255
G1 X126.415 Y122.761 E.00385
M106 S51
M106 S255
G1 X126.438 Y122.643 E.00385
M106 S51
M106 S255
G1 X126.469 Y122.528 E.00385
M106 S51
M106 S255
G1 F840
G1 X126.475 Y122.51 E.0006
M106 S51
M204 S250
G1 X126.869 Y122.585 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.952 Y122.395 E.00618
G3 X127.909 Y121.793 I1.048 J.605 E.03505
G1 X128 Y121.79 E.0027
G3 X126.844 Y122.643 I0 J1.21 E.18057
G1 X126.845 Y122.64 E.0001
; WIPE_START
M204 S10000
G1 X126.952 Y122.395 E-.10166
G1 X127.054 Y122.245 E-.06876
G1 X127.177 Y122.113 E-.06875
G1 X127.395 Y121.952 E-.10297
G1 X127.643 Y121.844 E-.10296
G1 X127.909 Y121.793 E-.10294
G1 X128 Y121.79 E-.03442
G1 X128.18 Y121.803 E-.06876
G1 X128.442 Y121.874 E-.10294
G1 X128.456 Y121.88 E-.00584
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I-.098 J-1.213 P1  F30000
G1 X116.593 Y122.836 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M106 S255
G1 F600
G1 X116.598 Y122.88 E.00142
M106 S51
M106 S255
G3 X116.598 Y123.12 I-1.616 J.12 E.00772
M106 S51
M106 S255
G1 X116.585 Y123.239 E.00385
M106 S51
M106 S255
G1 X116.562 Y123.357 E.00386
M106 S51
M106 S255
G1 X116.531 Y123.472 E.00385
M106 S51
M106 S255
G1 F840
G1 X116.492 Y123.585 E.00385
M106 S51
M106 S255
G1 F1440
G1 X116.444 Y123.695 E.00385
M106 S51
M106 S255
G1 F2040
G1 X116.388 Y123.801 E.00386
M106 S51
M106 S255
G1 F2880
G1 X116.324 Y123.903 E.00385
M106 S51
M106 S255
G1 F4232.291
G1 X116.253 Y123.999 E.00386
M106 S51
G1 F4429.731
G1 X116.242 Y124.011 E.00051
G1 F9820
G1 X115.999 Y124.253 E.01103
G1 F15476.087
G1 X115.694 Y124.441 E.01152
G3 X114.306 Y124.441 I-.694 J-1.452 E.04614
G1 X114.001 Y124.253 E.01152
G1 F9819.069
G1 X113.757 Y124.011 E.01103
G1 F4429.553
G1 X113.747 Y123.999 E.00051
M106 S255
G1 F4232.291
G1 X113.676 Y123.903 E.00386
M106 S51
M106 S255
G1 F2880
G1 X113.612 Y123.801 E.00385
M106 S51
M106 S255
G1 F2040
G1 X113.556 Y123.695 E.00386
M106 S51
M106 S255
G1 F1440
G1 X113.508 Y123.585 E.00385
M106 S51
M106 S255
G1 F840
G1 X113.469 Y123.472 E.00386
M106 S51
M106 S255
G1 F600
G1 X113.438 Y123.357 E.00385
M106 S51
M106 S255
G1 X113.415 Y123.239 E.00385
M106 S51
M106 S255
G1 X113.402 Y123.12 E.00385
M106 S51
M106 S255
G3 X113.402 Y122.88 I1.609 J-.12 E.00772
M106 S51
M106 S255
G1 X113.415 Y122.761 E.00385
M106 S51
M106 S255
G1 X113.438 Y122.643 E.00385
M106 S51
M106 S255
G1 X113.469 Y122.528 E.00385
M106 S51
M106 S255
G1 F840
G1 X113.508 Y122.415 E.00386
M106 S51
M106 S255
G1 F1440
G1 X113.556 Y122.305 E.00386
M106 S51
M106 S255
G1 F2040
G1 X113.612 Y122.199 E.00385
M106 S51
M106 S255
G1 F2880
G1 X113.676 Y122.097 E.00386
M106 S51
M106 S255
G1 F4229.231
G1 X113.747 Y122.001 E.00385
M106 S51
G1 F4427.574
G1 X113.757 Y121.989 E.00051
G1 F9816.254
G1 X114.001 Y121.747 E.01103
G1 F15476.087
G1 X114.305 Y121.557 E.01153
G3 X114.88 Y121.402 I.7 J1.452 E.01926
G3 X115.585 Y121.509 I.116 J1.605 E.02312
G1 X115.903 Y121.676 E.01153
G1 F12205.738
G1 X116.09 Y121.825 E.00771
G1 F7699.485
G1 X116.242 Y121.989 E.00719
G1 F4427.752
G1 X116.253 Y122.001 E.00051
M106 S255
G1 F4229.231
G1 X116.324 Y122.097 E.00385
M106 S51
M106 S255
G1 F2880
G1 X116.388 Y122.199 E.00386
M106 S51
M106 S255
G1 F2040
G1 X116.444 Y122.305 E.00385
M106 S51
M106 S255
G1 F1440
G1 X116.492 Y122.415 E.00386
M106 S51
M106 S255
G1 F840
G1 X116.531 Y122.528 E.00385
M106 S51
M106 S255
G1 F600
G1 X116.562 Y122.643 E.00385
M106 S51
M106 S255
G1 X116.585 Y122.761 E.00386
M106 S51
M106 S255
G1 X116.586 Y122.777 E.0005
M106 S51
M204 S250
G1 X116.197 Y122.881 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.209 Y123 E.00356
G3 X114.909 Y121.793 I-1.21 J0 E.1671
G1 X115 Y121.79 E.0027
G3 X116.179 Y122.731 I0 J1.21 E.04852
G1 X116.19 Y122.821 E.00272
; WIPE_START
M204 S10000
G1 X116.209 Y123 E-.06827
G1 X116.18 Y123.269 E-.10297
G1 X116.126 Y123.442 E-.0687
G1 X116.048 Y123.605 E-.06874
G1 X115.887 Y123.823 E-.10295
G1 X115.755 Y123.946 E-.06875
G1 X115.525 Y124.09 E-.10297
G1 X115.269 Y124.18 E-.103
G1 X115.077 Y124.201 E-.07364
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I.062 J1.215 P1  F30000
G1 X142.588 Y122.792 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M106 S255
G1 F600
G1 X142.598 Y122.88 E.00287
M106 S51
M106 S255
G3 X142.598 Y123.12 I-1.609 J.12 E.00772
M106 S51
M106 S255
G1 X142.585 Y123.239 E.00385
M106 S51
M106 S255
G1 X142.562 Y123.357 E.00385
M106 S51
M106 S255
G1 X142.531 Y123.472 E.00385
M106 S51
M106 S255
G1 F840
G1 X142.492 Y123.585 E.00386
M106 S51
M106 S255
G1 F1440
G1 X142.444 Y123.695 E.00385
M106 S51
M106 S255
G1 F2040
G1 X142.388 Y123.801 E.00386
M106 S51
M106 S255
G1 F2880
G1 X142.324 Y123.903 E.00385
M106 S51
M106 S255
G1 F4232.291
G1 X142.253 Y123.999 E.00386
M106 S51
G1 F4429.553
G1 X142.242 Y124.011 E.00051
G1 F9818.67
G1 X141.999 Y124.253 E.01103
G1 F15476.087
G1 X141.695 Y124.443 E.01153
G3 X140.305 Y124.443 I-.695 J-1.445 E.04623
G1 X140.001 Y124.253 E.01153
G1 F9820
G1 X139.757 Y124.011 E.01103
G1 F4429.731
G1 X139.747 Y123.999 E.00051
M106 S255
G1 F4232.291
G1 X139.676 Y123.903 E.00386
M106 S51
M106 S255
G1 F2880
G1 X139.612 Y123.801 E.00385
M106 S51
M106 S255
G1 F2040
G1 X139.556 Y123.695 E.00386
M106 S51
M106 S255
G1 F1440
G1 X139.508 Y123.585 E.00385
M106 S51
M106 S255
G1 F840
G1 X139.469 Y123.472 E.00385
M106 S51
M106 S255
G1 F600
G1 X139.438 Y123.357 E.00385
M106 S51
M106 S255
G1 X139.415 Y123.239 E.00386
M106 S51
M106 S255
G1 X139.402 Y123.12 E.00385
M106 S51
M106 S255
G3 X139.402 Y122.88 I1.616 J-.12 E.00772
M106 S51
M106 S255
G1 X139.415 Y122.761 E.00385
M106 S51
M106 S255
G1 X139.438 Y122.643 E.00386
M106 S51
M106 S255
G1 X139.469 Y122.528 E.00385
M106 S51
M106 S255
G1 F840
G1 X139.508 Y122.415 E.00385
M106 S51
M106 S255
G1 F1440
G1 X139.556 Y122.305 E.00386
M106 S51
M106 S255
G1 F2040
G1 X139.612 Y122.199 E.00385
M106 S51
M106 S255
G1 F2880
G1 X139.676 Y122.097 E.00386
M106 S51
M106 S255
G1 F4229.231
G1 X139.747 Y122.001 E.00385
M106 S51
G1 F4427.752
G1 X139.757 Y121.989 E.00051
G1 F9816.92
G1 X140.001 Y121.747 E.01103
G1 F15476.087
G1 X140.305 Y121.557 E.01153
G3 X140.88 Y121.402 I.7 J1.452 E.01926
G3 X141.585 Y121.509 I.116 J1.605 E.02312
G1 X141.903 Y121.676 E.01154
G1 F12204.1
G1 X142.09 Y121.825 E.0077
G1 F7699.25
G1 X142.242 Y121.989 E.00719
G1 F4427.574
G1 X142.253 Y122.001 E.00051
M106 S255
G1 F4229.231
G1 X142.324 Y122.097 E.00385
M106 S51
M106 S255
G1 F2880
G1 X142.388 Y122.199 E.00386
M106 S51
M106 S255
G1 F2040
G1 X142.444 Y122.305 E.00385
M106 S51
M106 S255
G1 F1440
G1 X142.492 Y122.415 E.00386
M106 S51
M106 S255
G1 F840
G1 X142.531 Y122.528 E.00386
M106 S51
M106 S255
G1 F600
G1 X142.562 Y122.643 E.00385
M106 S51
M106 S255
G1 X142.579 Y122.732 E.00291
M106 S51
M204 S250
G1 X142.193 Y122.837 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X142.206 Y122.91 E.00221
G3 X140.909 Y121.793 I-1.206 J.09 E.1698
G1 X141 Y121.79 E.0027
G3 X142.156 Y122.643 I0 J1.21 E.04583
G1 X142.182 Y122.778 E.00407
; WIPE_START
M204 S10000
G1 X142.206 Y122.91 E-.05096
G1 X142.207 Y123.091 E-.06877
G1 X142.156 Y123.357 E-.10294
G1 X142.048 Y123.605 E-.10298
G1 X141.887 Y123.823 E-.10295
G1 X141.755 Y123.946 E-.06875
G1 X141.525 Y124.09 E-.10295
G1 X141.357 Y124.156 E-.06876
G1 X141.122 Y124.201 E-.09094
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I-.141 J-1.209 P1  F30000
G1 X102.602 Y128.701 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F15476.087
G1 X102.602 Y117.299 E.36667
G1 X153.398 Y117.299 E1.63341
G1 X153.398 Y128.701 E.36667
G1 X102.662 Y128.701 E1.63148
M204 S250
G1 X102.21 Y129.093 F30000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X102.21 Y116.907 E.363
G1 X153.79 Y116.907 E1.53639
G1 X153.79 Y129.093 E.363
G1 X102.27 Y129.093 E1.53461
; WIPE_START
M204 S10000
G1 X102.26 Y127.093 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.823 Y128.122 Z4.6 F30000
G1 X112.878 Y128.538 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42523
M106 S255
G1 F3000
G1 X112.878 Y117.632 E.32935
G1 X112.496 Y117.632 E.01155
G1 X112.496 Y128.368 E.32423
G1 X112.113 Y128.368 E.01155
G1 X112.113 Y117.632 E.32423
G1 X111.731 Y117.632 E.01155
G1 X111.731 Y128.368 E.32423
G1 X111.349 Y128.368 E.01155
G1 X111.349 Y117.632 E.32423
G1 X110.966 Y117.632 E.01155
G1 X110.966 Y128.368 E.32423
G1 X110.584 Y128.368 E.01155
G1 X110.584 Y117.632 E.32423
G1 X110.202 Y117.632 E.01155
G1 X110.202 Y128.368 E.32423
G1 X109.82 Y128.368 E.01155
G1 X109.82 Y117.632 E.32423
G1 X109.437 Y117.632 E.01155
G1 X109.437 Y128.368 E.32423
G1 X109.055 Y128.368 E.01155
G1 X109.055 Y117.632 E.32423
M73 P92 R1
G1 X108.673 Y117.632 E.01155
G1 X108.673 Y128.368 E.32423
G1 X108.29 Y128.368 E.01155
G1 X108.29 Y117.632 E.32423
G1 X107.908 Y117.632 E.01155
G1 X107.908 Y128.368 E.32423
G1 X107.526 Y128.368 E.01155
G1 X107.526 Y117.632 E.32423
G1 X107.143 Y117.632 E.01155
G1 X107.143 Y128.368 E.32423
G1 X106.761 Y128.368 E.01155
G1 X106.761 Y117.632 E.32423
G1 X106.379 Y117.632 E.01155
G1 X106.379 Y128.368 E.32423
G1 X105.996 Y128.368 E.01155
G1 X105.996 Y117.632 E.32423
G1 X105.614 Y117.632 E.01155
G1 X105.614 Y128.368 E.32423
G1 X105.232 Y128.368 E.01155
G1 X105.232 Y117.632 E.32423
G1 X104.85 Y117.632 E.01155
G1 X104.85 Y128.368 E.32423
G1 X104.467 Y128.368 E.01155
G1 X104.467 Y117.632 E.32423
G1 X104.085 Y117.632 E.01155
G1 X104.085 Y128.368 E.32423
G1 X103.703 Y128.368 E.01155
G1 X103.703 Y117.632 E.32423
G1 X103.32 Y117.632 E.01155
G1 X103.32 Y128.368 E.32423
G1 X102.938 Y128.368 E.01155
G1 X102.938 Y117.462 E.32935
M106 S51
; WIPE_START
G1 X102.938 Y119.462 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.464 Y118.192 Z4.6 F30000
G1 X114.79 Y117.462 Z4.6
G1 Z4.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X114.79 Y121.08 E.10925
G1 X114.407 Y121.158 E.01178
G1 X114.407 Y117.632 E.10648
G1 X114.025 Y117.632 E.01155
G1 X114.025 Y121.327 E.1116
G2 X113.643 Y121.634 I.619 J1.163 E.01489
G1 X113.643 Y117.632 E.12086
G1 X113.26 Y117.632 E.01155
G1 X113.26 Y122.172 E.1371
G1 X113.148 Y122.429 E.00847
G2 X113.148 Y123.571 I2.012 J.571 E.03494
G1 X113.26 Y123.828 E.00847
G1 X113.26 Y128.368 E.1371
G1 X113.643 Y128.368 E.01155
G1 X113.643 Y124.375 E.12058
G2 X114.025 Y124.673 I1.178 J-1.119 E.01468
G1 X114.025 Y128.368 E.1116
G1 X114.407 Y128.368 E.01155
G1 X114.407 Y124.842 E.10648
G1 X114.79 Y124.92 E.01178
G1 X114.79 Y128.538 E.10925
M106 S51
G1 X115.02 Y128.382 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X114.956 Y128.419 E.00198
G1 X115.005 Y128.447 E.00151
; WIPE_START
G1 X114.956 Y128.419 E-.32875
G1 X115.02 Y128.382 E-.43125
; WIPE_END
G1 E-.04 F1800
G1 X115.336 Y124.724 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42389
M106 S255
G1 F3000
G1 X115.209 Y128.117 E.10219
G1 X115.253 Y128.368 E.00767
G1 X115.581 Y128.368 E.00986
G1 X115.714 Y124.794 E.10762
G2 X116.103 Y124.581 I-.369 J-1.134 E.01344
G1 X115.962 Y128.368 E.11405
G1 X116.343 Y128.368 E.01147
G1 X116.51 Y123.911 E.13421
M106 S51
; WIPE_START
G1 X116.435 Y125.91 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I1.216 J.046 P1  F30000
G1 X116.573 Y122.215 Z4.6
G1 Z4.2
G1 E.8 F1800
M106 S255
G1 F3000
G1 X116.745 Y117.632 E.13801
G1 X116.364 Y117.632 E.01147
G1 X116.219 Y121.496 E.11636
G1 X115.847 Y121.258 E.0133
G1 X115.982 Y117.632 E.10919
G1 X115.601 Y117.632 E.01147
G1 X115.47 Y121.129 E.10532
G1 X115.208 Y121.079 E.00804
G1 X115.208 Y117.957 E.09398
G1 X115.226 Y117.462 E.01488
M106 S51
G1 X115.022 Y117.544 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X114.959 Y117.581 E.00198
G1 X115.007 Y117.609 E.00151
; WIPE_START
G1 X114.959 Y117.581 E-.32877
G1 X115.022 Y117.544 E-.43123
; WIPE_END
G1 E-.04 F1800
G1 X117.132 Y117.462 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42389
M106 S255
G1 F3000
G1 X116.724 Y128.368 E.32843
G1 X117.105 Y128.368 E.01147
G1 X117.507 Y117.632 E.32332
G1 X117.889 Y117.632 E.01147
G1 X117.487 Y128.368 E.32332
G1 X117.868 Y128.368 E.01147
G1 X118.27 Y117.632 E.32332
G1 X118.651 Y117.632 E.01147
G1 X118.249 Y128.368 E.32332
G1 X118.63 Y128.368 E.01147
G1 X119.032 Y117.632 E.32332
G1 X119.413 Y117.632 E.01147
G1 X119.012 Y128.368 E.32332
G1 X119.393 Y128.368 E.01147
G1 X119.795 Y117.632 E.32332
G1 X120.176 Y117.632 E.01147
G1 X119.774 Y128.368 E.32332
G1 X120.155 Y128.368 E.01147
G1 X120.557 Y117.632 E.32332
G1 X120.938 Y117.632 E.01147
G1 X120.537 Y128.368 E.32332
G1 X120.918 Y128.368 E.01147
G1 X121.32 Y117.632 E.32332
G1 X121.701 Y117.632 E.01147
G1 X121.299 Y128.368 E.32332
G1 X121.68 Y128.368 E.01147
G1 X122.082 Y117.632 E.32332
M73 P93 R1
G1 X122.463 Y117.632 E.01147
G1 X122.062 Y128.368 E.32332
G1 X122.443 Y128.368 E.01147
G1 X122.845 Y117.632 E.32332
G1 X123.226 Y117.632 E.01147
G1 X122.824 Y128.368 E.32332
G1 X123.205 Y128.368 E.01147
G1 X123.607 Y117.632 E.32332
G1 X123.988 Y117.632 E.01147
G1 X123.586 Y128.368 E.32332
G1 X123.968 Y128.368 E.01147
G1 X124.37 Y117.632 E.32332
G1 X124.751 Y117.632 E.01147
G1 X124.349 Y128.368 E.32332
G1 X124.73 Y128.368 E.01147
G1 X125.132 Y117.632 E.32332
G1 X125.513 Y117.632 E.01147
G1 X125.111 Y128.368 E.32332
G1 X125.493 Y128.368 E.01147
G1 X125.895 Y117.632 E.32332
G1 X126.276 Y117.632 E.01147
G1 X125.874 Y128.368 E.32332
G1 X126.255 Y128.368 E.01147
G1 X126.415 Y124.095 E.12867
G2 X126.781 Y124.504 I1.262 J-.763 E.01659
G1 X126.636 Y128.368 E.11638
G1 X127.018 Y128.368 E.01147
G1 X127.154 Y124.732 E.10951
G1 X127.429 Y124.852 E.00904
G1 X127.53 Y124.871 E.00309
G1 X127.399 Y128.368 E.10532
G1 X127.747 Y128.368 E.01048
G1 X127.788 Y128.156 E.00649
G1 X127.915 Y124.762 E.10223
M106 S51
G1 X128.21 Y124.747 F30000
; LINE_WIDTH: 0.42414
M106 S255
G1 F3000
G1 X128.21 Y128.135 E.10201
G1 X128.253 Y128.368 E.00714
G1 X128.591 Y128.368 E.01019
G1 X128.591 Y124.843 E.10615
G1 X128.972 Y124.676 E.01254
G1 X128.972 Y128.368 E.11119
G1 X129.354 Y128.368 E.01148
G1 X129.354 Y124.381 E.12008
G2 X129.641 Y124.007 I-.843 J-.947 E.01428
G1 X129.735 Y123.859 E.00528
G1 X129.735 Y128.368 E.1358
G1 X130.116 Y128.368 E.01148
G1 X130.116 Y117.632 E.3233
G1 X130.497 Y117.632 E.01148
G1 X130.497 Y128.368 E.3233
G1 X130.878 Y128.368 E.01148
G1 X130.878 Y117.632 E.3233
G1 X131.26 Y117.632 E.01148
G1 X131.26 Y128.368 E.3233
G1 X131.641 Y128.368 E.01148
G1 X131.641 Y117.632 E.3233
G1 X132.022 Y117.632 E.01148
G1 X132.022 Y128.368 E.3233
G1 X132.403 Y128.368 E.01148
G1 X132.403 Y117.632 E.3233
G1 X132.785 Y117.632 E.01148
G1 X132.785 Y128.368 E.3233
G1 X133.166 Y128.368 E.01148
G1 X133.166 Y117.632 E.3233
G1 X133.547 Y117.632 E.01148
G1 X133.547 Y128.368 E.3233
G1 X133.928 Y128.368 E.01148
G1 X133.928 Y117.632 E.3233
G1 X134.309 Y117.632 E.01148
G1 X134.309 Y128.368 E.3233
G1 X134.691 Y128.368 E.01148
G1 X134.691 Y117.632 E.3233
M73 P93 R0
G1 X135.072 Y117.632 E.01148
G1 X135.072 Y128.368 E.3233
G1 X135.453 Y128.368 E.01148
G1 X135.453 Y117.632 E.3233
G1 X135.834 Y117.632 E.01148
G1 X135.834 Y128.368 E.3233
G1 X136.215 Y128.368 E.01148
G1 X136.215 Y117.632 E.3233
G1 X136.597 Y117.632 E.01148
G1 X136.597 Y128.368 E.3233
G1 X136.978 Y128.368 E.01148
G1 X136.978 Y117.632 E.3233
G1 X137.359 Y117.632 E.01148
G1 X137.359 Y128.368 E.3233
G1 X137.74 Y128.368 E.01148
G1 X137.74 Y117.632 E.3233
G1 X138.122 Y117.632 E.01148
G1 X138.122 Y128.368 E.3233
G1 X138.503 Y128.368 E.01148
G1 X138.503 Y117.632 E.3233
G1 X138.884 Y117.632 E.01148
G1 X138.884 Y128.538 E.32841
M106 S51
; WIPE_START
G1 X138.884 Y126.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.79 Y128.538 Z4.6 F30000
G1 Z4.2
G1 E.8 F1800
M106 S255
G1 F3000
M73 P94 R0
G1 X140.79 Y124.92 E.10894
G1 X140.409 Y124.843 E.01171
G1 X140.409 Y128.368 E.10616
G1 X140.028 Y128.368 E.01148
G1 X140.028 Y124.663 E.11156
G3 X139.646 Y124.37 I.624 J-1.204 E.01457
G1 X139.646 Y128.368 E.1204
G1 X139.265 Y128.368 E.01148
G1 X139.254 Y123.841 E.13633
G3 X139.265 Y122.161 I1.758 J-.828 E.05233
G1 X139.265 Y117.632 E.13637
G1 X139.646 Y117.632 E.01148
G1 X139.646 Y121.63 E.1204
G1 X139.69 Y121.587 E.00184
G3 X140.028 Y121.337 I.718 J.616 E.01278
G1 X140.028 Y117.632 E.11156
G1 X140.409 Y117.632 E.01148
G1 X140.409 Y121.157 E.10616
G1 X140.79 Y121.08 E.01171
G1 X140.79 Y117.462 E.10894
M106 S51
G1 X141.022 Y117.544 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X140.959 Y117.581 E.00198
G1 X141.007 Y117.609 E.00151
G1 X141.21 Y117.462 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.42523
M106 S255
G1 F3000
G1 X141.21 Y121.08 E.10925
G1 X141.593 Y121.158 E.01178
G1 X141.593 Y117.632 E.10648
G1 X141.975 Y117.632 E.01155
G1 X141.975 Y121.327 E.1116
G3 X142.357 Y121.634 I-.619 J1.163 E.01489
G1 X142.357 Y117.632 E.12086
G1 X142.74 Y117.632 E.01155
G1 X142.74 Y122.172 E.1371
G1 X142.852 Y122.429 E.00847
G3 X142.852 Y123.571 I-2.012 J.571 E.03494
G1 X142.74 Y123.828 E.00847
G1 X142.74 Y128.368 E.1371
G1 X142.357 Y128.368 E.01155
G1 X142.357 Y124.374 E.12061
G3 X141.975 Y124.662 I-.97 J-.89 E.01453
G1 X141.975 Y128.368 E.11191
G1 X141.593 Y128.368 E.01155
G1 X141.593 Y124.842 E.10649
G1 X141.21 Y124.92 E.01178
G1 X141.21 Y128.538 E.10925
M106 S51
G1 X141.02 Y128.382 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X140.956 Y128.419 E.00198
G1 X141.005 Y128.447 E.00151
; WIPE_START
G1 X140.956 Y128.419 E-.32873
G1 X141.02 Y128.382 E-.43127
; WIPE_END
G1 E-.04 F1800
G1 X142.463 Y120.887 Z4.6 F30000
G1 X143.122 Y117.462 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42523
M106 S255
G1 F3000
G1 X143.122 Y128.368 E.32935
G1 X143.504 Y128.368 E.01155
G1 X143.504 Y117.632 E.32423
G1 X143.887 Y117.632 E.01155
G1 X143.887 Y128.368 E.32423
G1 X144.269 Y128.368 E.01155
G1 X144.269 Y117.632 E.32423
G1 X144.651 Y117.632 E.01155
G1 X144.651 Y128.368 E.32423
G1 X145.033 Y128.368 E.01155
G1 X145.033 Y117.632 E.32423
G1 X145.416 Y117.632 E.01155
G1 X145.416 Y128.368 E.32423
G1 X145.798 Y128.368 E.01155
G1 X145.798 Y117.632 E.32423
G1 X146.18 Y117.632 E.01155
G1 X146.18 Y128.368 E.32423
G1 X146.563 Y128.368 E.01155
G1 X146.563 Y117.632 E.32423
G1 X146.945 Y117.632 E.01155
G1 X146.945 Y128.368 E.32423
G1 X147.327 Y128.368 E.01155
G1 X147.327 Y117.632 E.32423
G1 X147.71 Y117.632 E.01155
G1 X147.71 Y128.368 E.32423
G1 X148.092 Y128.368 E.01155
G1 X148.092 Y117.632 E.32423
G1 X148.474 Y117.632 E.01155
G1 X148.474 Y128.368 E.32423
G1 X148.857 Y128.368 E.01155
G1 X148.857 Y117.632 E.32423
G1 X149.239 Y117.632 E.01155
G1 X149.239 Y128.368 E.32423
G1 X149.621 Y128.368 E.01155
G1 X149.621 Y117.632 E.32423
G1 X150.004 Y117.632 E.01155
G1 X150.004 Y128.368 E.32423
G1 X150.386 Y128.368 E.01155
G1 X150.386 Y117.632 E.32423
G1 X150.768 Y117.632 E.01155
G1 X150.768 Y128.368 E.32423
G1 X151.15 Y128.368 E.01155
G1 X151.15 Y117.632 E.32423
G1 X151.533 Y117.632 E.01155
G1 X151.533 Y128.368 E.32423
G1 X151.915 Y128.368 E.01155
G1 X151.915 Y117.632 E.32423
G1 X152.297 Y117.632 E.01155
G1 X152.297 Y128.368 E.32423
G1 X152.68 Y128.368 E.01155
G1 X152.68 Y117.632 E.32423
G1 X153.062 Y117.632 E.01155
G1 X153.062 Y128.538 E.32935
M106 S51
; WIPE_START
G1 X153.062 Y126.538 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I.196 J-1.201 P1  F30000
G1 X129.735 Y122.723 Z4.6
G1 Z4.2
G1 E.8 F1800
; LINE_WIDTH: 0.42414
M106 S255
G1 F3000
G1 X129.735 Y117.632 E.15331
G1 X129.354 Y117.632 E.01148
G1 X129.354 Y121.619 E.12008
G1 X128.972 Y121.324 E.01452
G1 X128.972 Y117.632 E.11119
G1 X128.591 Y117.632 E.01148
G1 X128.591 Y121.157 E.10615
G1 X128.21 Y121.08 E.01171
G1 X128.21 Y117.462 E.10894
M106 S51
G1 X128.022 Y117.544 F30000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X127.959 Y117.581 E.00198
G1 X128.007 Y117.609 E.00151
G1 X127.807 Y117.462 F30000
; FEATURE: Bridge
; LINE_WIDTH: 0.42389
M106 S255
G1 F3000
G1 X127.671 Y121.102 E.10962
G2 X127.286 Y121.211 I.045 J.899 E.01215
G1 X127.419 Y117.632 E.10778
G1 X127.038 Y117.632 E.01147
G1 X126.896 Y121.421 E.11411
G2 X126.502 Y121.775 I.739 J1.22 E.01604
G1 X126.663 Y117.462 E.12988
M106 S51
; WIPE_START
G1 X126.589 Y119.461 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P95 R0
G1 X127.798 Y126.997 Z4.6 F30000
G1 X128.02 Y128.382 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F15000
G1 X127.956 Y128.419 E.00198
G1 X128.005 Y128.447 E.00151
; WIPE_START
G1 X127.956 Y128.419 E-.32873
G1 X128.02 Y128.382 E-.43127
; WIPE_END
G1 E-.04 F1800
G1 X131.429 Y135.211 Z4.6 F30000
G1 X139.21 Y150.802 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X153.79 Y150.802 E.43429
G1 X153.79 Y151.49 E.0205
G1 X139.21 Y151.49 E.43429
G1 X139.21 Y150.862 E.01871
M204 S10000
G1 X139.406 Y151.146 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.33909
G1 F15000
G1 X153.594 Y151.146 E.33193
; WIPE_START
G1 X151.594 Y151.146 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X143.963 Y151.006 Z4.6 F30000
G1 X132.79 Y150.802 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X132.79 Y151.49 E.0205
G1 X123.21 Y151.49 E.28536
G1 X123.21 Y150.802 E.0205
G1 X132.73 Y150.802 E.28357
M204 S10000
G1 X132.594 Y151.146 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.33909
G1 F15000
G1 X123.406 Y151.146 E.21496
; WIPE_START
G1 X125.406 Y151.146 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X117.78 Y150.841 Z4.6 F30000
G1 X116.79 Y150.802 Z4.6
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X116.79 Y151.49 E.0205
G1 X102.21 Y151.49 E.43429
G1 X102.21 Y150.802 E.0205
G1 X116.73 Y150.802 E.4325
M204 S10000
G1 X116.594 Y151.146 F30000
; FEATURE: Gap infill
; LINE_WIDTH: 0.33909
G1 F15000
G1 X102.406 Y151.146 E.33193
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X104.406 Y151.146 E-.76
; WIPE_END
G1 E-.04 F1800
; layer num/total_layer_count: 22/22
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
M106 S99.45
G17
G3 Z4.6 I1.217 J0 P1  F30000
;========Date 20250206========
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
M971 S11 C10 O0

M623

; OBJECT_ID: 15
G1 X126.678 Y122.518
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X126.73 Y122.389 E.00415
G3 X127.895 Y121.593 I1.27 J.61 E.04399
G1 X128.105 Y121.593 E.00628
G3 X126.653 Y122.585 I-.105 J1.405 E.20708
G1 X126.657 Y122.574 E.00033
; WIPE_START
M204 S10000
G1 X126.73 Y122.389 E-.07577
G1 X126.835 Y122.205 E-.08012
G1 X126.966 Y122.041 E-.0801
G1 X127.121 Y121.897 E-.08012
G1 X127.394 Y121.73 E-.12175
G1 X127.686 Y121.625 E-.11799
G1 X127.895 Y121.593 E-.08011
G1 X128.105 Y121.593 E-.08013
G1 X128.22 Y121.611 E-.04392
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.104 J1.213 P1  F30000
G1 X142.397 Y122.822 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S5000
G1 X142.409 Y123 E.00531
G3 X140.895 Y121.593 I-1.409 J-.002 E.19452
G1 X141.105 Y121.593 E.00628
G3 X142.389 Y122.763 I-.105 J1.405 E.05572
; WIPE_START
M204 S10000
G1 X142.409 Y123 E-.09047
G1 X142.395 Y123.21 E-.08007
G1 X142.348 Y123.416 E-.08012
G1 X142.271 Y123.612 E-.08011
G1 X142.165 Y123.795 E-.08013
G1 X142.034 Y123.959 E-.0801
G1 X141.879 Y124.103 E-.08012
G1 X141.606 Y124.269 E-.12175
G1 X141.44 Y124.33 E-.06714
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I.071 J-1.215 P1  F30000
G1 X116.401 Y122.872 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S5000
G1 X116.409 Y123 E.00383
G3 X114.895 Y121.593 I-1.409 J-.002 E.19452
G1 X115.105 Y121.593 E.00628
G3 X116.393 Y122.79 I-.105 J1.405 E.05655
G1 X116.395 Y122.812 E.00066
; WIPE_START
M204 S10000
G1 X116.409 Y123 E-.07165
G1 X116.395 Y123.21 E-.08007
G1 X116.348 Y123.416 E-.08012
G1 X116.271 Y123.612 E-.08011
G1 X116.165 Y123.795 E-.08013
G1 X116.034 Y123.959 E-.0801
G1 X115.879 Y124.103 E-.08012
G1 X115.606 Y124.269 E-.12175
G1 X115.393 Y124.347 E-.08596
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.397 J-1.15 P1  F30000
G1 X102.21 Y128.897 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S5000
G1 X102.21 Y117.103 E.35128
G1 X153.79 Y117.103 E1.53639
G1 X153.79 Y128.897 E.35128
G1 X102.27 Y128.897 E1.53461
; WIPE_START
M204 S10000
G1 X102.26 Y126.897 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.891 Y127.043 Z4.8 F30000
G1 X153.583 Y127.88 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Top surface
G1 F12000
M204 S2000
G1 X152.773 Y128.689 E.03409
G1 X152.24 Y128.689
G1 X153.583 Y127.347 E.05655
G1 X153.583 Y126.814
G1 X151.707 Y128.689 E.07901
G1 X151.174 Y128.689
G1 X153.583 Y126.28 E.10148
G1 X153.583 Y125.747
G1 X150.64 Y128.689 E.12394
G1 X150.107 Y128.689
G1 X153.583 Y125.214 E.1464
G1 X153.583 Y124.681
G1 X149.574 Y128.689 E.16887
G1 X149.041 Y128.689
G1 X153.583 Y124.147 E.19133
G1 X153.583 Y123.614
G1 X148.507 Y128.689 E.21379
G1 X147.974 Y128.689
G1 X153.583 Y123.081 E.23626
G1 X153.583 Y122.547
G1 X147.441 Y128.689 E.25872
G1 X146.908 Y128.689
G1 X153.583 Y122.014 E.28118
G1 X153.583 Y121.481
G1 X146.374 Y128.689 E.30364
G1 X145.841 Y128.689
G1 X153.583 Y120.948 E.32611
G1 X153.583 Y120.414
G1 X145.308 Y128.689 E.34857
G1 X144.775 Y128.689
G1 X153.583 Y119.881 E.37103
G1 X153.583 Y119.348
G1 X144.241 Y128.689 E.3935
G1 X143.708 Y128.689
G1 X153.583 Y118.815 E.41596
G1 X153.583 Y118.281
G1 X143.175 Y128.689 E.43842
G1 X142.642 Y128.689
G1 X153.583 Y117.748 E.46089
G1 X153.487 Y117.311
G1 X142.108 Y128.689 E.47931
G1 X141.575 Y128.689
G1 X152.954 Y117.311 E.47931
G1 X152.42 Y117.311
G1 X141.042 Y128.689 E.47931
G1 X140.509 Y128.689
G1 X151.887 Y117.311 E.47931
G1 X151.354 Y117.311
G1 X139.975 Y128.689 E.47931
G1 X139.442 Y128.689
G1 X150.82 Y117.311 E.47931
G1 X150.287 Y117.311
G1 X138.909 Y128.689 E.47931
G1 X138.375 Y128.689
G1 X149.754 Y117.311 E.47931
G1 X149.221 Y117.311
G1 X137.842 Y128.689 E.47931
G1 X137.309 Y128.689
G1 X141.453 Y124.545 E.17455
G1 X140.855 Y124.61
G1 X136.776 Y128.689 E.17182
G1 X136.242 Y128.689
G1 X140.43 Y124.502 E.17638
G1 X140.078 Y124.32
G1 X135.709 Y128.689 E.18404
G1 X135.176 Y128.689
G1 X139.792 Y124.074 E.19444
G1 X139.574 Y123.758
G1 X134.643 Y128.689 E.20773
G1 X134.109 Y128.689
M73 P96 R0
G1 X139.429 Y123.37 E.22408
G1 X139.391 Y122.875
G1 X133.576 Y128.689 E.24494
G1 X133.043 Y128.689
G1 X139.737 Y121.996 E.28197
; WIPE_START
M204 S10000
G1 X138.322 Y123.41 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.01 J1.217 P1  F30000
G1 X142.554 Y123.444 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X148.687 Y117.311 E.25836
G1 X148.154 Y117.311
G1 X142.608 Y122.857 E.23364
G1 X142.508 Y122.424
G1 X147.621 Y117.311 E.21539
G1 X147.088 Y117.311
G1 X142.325 Y122.073 E.20061
G1 X142.072 Y121.793
G1 X146.554 Y117.311 E.18881
G1 X146.021 Y117.311
G1 X141.755 Y121.577 E.17973
G1 X141.373 Y121.426
G1 X145.488 Y117.311 E.17334
G1 X144.955 Y117.311
G1 X140.879 Y121.386 E.17167
G1 X140.011 Y121.721
G1 X144.421 Y117.311 E.18577
G1 X143.888 Y117.311
G1 X132.51 Y128.689 E.47931
G1 X131.976 Y128.689
G1 X143.355 Y117.311 E.47931
G1 X142.822 Y117.311
G1 X131.443 Y128.689 E.47931
G1 X130.91 Y128.689
G1 X142.288 Y117.311 E.47931
G1 X141.755 Y117.311
G1 X130.377 Y128.689 E.47931
G1 X129.843 Y128.689
G1 X141.222 Y117.311 E.47931
G1 X140.689 Y117.311
G1 X129.31 Y128.689 E.47931
G1 X128.777 Y128.689
G1 X140.155 Y117.311 E.47931
G1 X139.622 Y117.311
G1 X128.244 Y128.689 E.47931
G1 X127.71 Y128.689
G1 X139.089 Y117.311 E.47931
G1 X138.556 Y117.311
G1 X127.177 Y128.689 E.47931
G1 X126.644 Y128.689
G1 X138.022 Y117.311 E.47931
G1 X137.489 Y117.311
G1 X126.111 Y128.689 E.47931
G1 X125.577 Y128.689
G1 X136.956 Y117.311 E.47931
G1 X136.423 Y117.311
G1 X125.044 Y128.689 E.47931
G1 X124.511 Y128.689
G1 X128.815 Y124.385 E.18132
G1 X128.053 Y124.614
G1 X123.978 Y128.689 E.17167
G1 X123.444 Y128.689
G1 X127.577 Y124.556 E.1741
G1 X127.203 Y124.397
G1 X122.911 Y128.689 E.18081
G1 X122.378 Y128.689
G1 X126.893 Y124.174 E.19019
G1 X126.648 Y123.886
G1 X121.845 Y128.689 E.20234
G1 X121.311 Y128.689
G1 X126.473 Y123.527 E.21744
G1 X126.387 Y123.08
G1 X120.778 Y128.689 E.23629
G1 X120.245 Y128.689
G1 X126.481 Y122.453 E.26269
; WIPE_START
M204 S10000
G1 X125.066 Y123.868 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.404 Y123.796 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X135.889 Y117.311 E.27318
G1 X135.356 Y117.311
G1 X129.615 Y123.052 E.24185
G1 X129.559 Y122.575
G1 X134.823 Y117.311 E.22175
G1 X134.29 Y117.311
G1 X129.401 Y122.199 E.20592
G1 X129.177 Y121.89
G1 X133.756 Y117.311 E.19291
G1 X133.223 Y117.311
G1 X128.88 Y121.654 E.18296
G1 X128.521 Y121.48
G1 X132.69 Y117.311 E.17561
G1 X132.156 Y117.311
G1 X128.081 Y121.386 E.17167
G1 X127.441 Y121.493
G1 X131.623 Y117.311 E.17617
G1 X131.09 Y117.311
G1 X119.711 Y128.689 E.47931
G1 X119.178 Y128.689
G1 X130.557 Y117.311 E.47931
G1 X130.023 Y117.311
G1 X118.645 Y128.689 E.47931
G1 X118.112 Y128.689
G1 X129.49 Y117.311 E.47931
G1 X128.957 Y117.311
G1 X117.578 Y128.689 E.47931
G1 X117.045 Y128.689
G1 X128.424 Y117.311 E.47931
G1 X127.89 Y117.311
G1 X116.512 Y128.689 E.47931
G1 X115.979 Y128.689
G1 X127.357 Y117.311 E.47931
G1 X126.824 Y117.311
G1 X115.445 Y128.689 E.47931
G1 X114.912 Y128.689
G1 X126.291 Y117.311 E.47931
G1 X125.757 Y117.311
G1 X114.379 Y128.689 E.47931
G1 X113.846 Y128.689
G1 X125.224 Y117.311 E.47931
M73 P97 R0
G1 X124.691 Y117.311
G1 X113.312 Y128.689 E.47931
G1 X112.779 Y128.689
G1 X124.158 Y117.311 E.47931
G1 X123.624 Y117.311
G1 X112.246 Y128.689 E.47931
G1 X111.713 Y128.689
G1 X123.091 Y117.311 E.47931
G1 X122.558 Y117.311
G1 X116.593 Y123.276 E.25129
G1 X116.596 Y122.739
G1 X122.025 Y117.311 E.22868
G1 X121.491 Y117.311
G1 X116.471 Y122.331 E.21147
G1 X116.268 Y122.001
G1 X120.958 Y117.311 E.19758
G1 X120.425 Y117.311
G1 X116.005 Y121.731 E.18619
G1 X115.669 Y121.534
G1 X119.892 Y117.311 E.17789
G1 X119.358 Y117.311
G1 X115.262 Y121.407 E.17256
G1 X114.727 Y121.409
G1 X118.825 Y117.311 E.17263
; WIPE_START
M204 S10000
G1 X117.411 Y118.725 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-1.032 J-.645 P1  F30000
G1 X111.179 Y128.689 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F12000
M204 S2000
G1 X115.278 Y124.59 E.17267
G1 X114.742 Y124.593
G1 X110.646 Y128.689 E.17254
G1 X110.113 Y128.689
G1 X114.335 Y124.467 E.17784
G1 X113.998 Y124.271
G1 X109.58 Y128.689 E.18612
G1 X109.046 Y128.689
G1 X113.734 Y124.001 E.19747
G1 X113.53 Y123.672
G1 X108.513 Y128.689 E.21134
G1 X107.98 Y128.689
G1 X113.405 Y123.264 E.22852
G1 X113.406 Y122.73
G1 X107.447 Y128.689 E.25105
G1 X106.913 Y128.689
G1 X118.292 Y117.311 E.47931
G1 X117.759 Y117.311
G1 X106.38 Y128.689 E.47931
G1 X105.847 Y128.689
G1 X117.225 Y117.311 E.47931
G1 X116.692 Y117.311
G1 X105.314 Y128.689 E.47931
G1 X104.78 Y128.689
G1 X116.159 Y117.311 E.47931
G1 X115.626 Y117.311
G1 X104.247 Y128.689 E.47931
G1 X103.714 Y128.689
G1 X115.092 Y117.311 E.47931
G1 X114.559 Y117.311
G1 X103.181 Y128.689 E.47931
G1 X102.647 Y128.689
G1 X114.026 Y117.311 E.47931
G1 X113.492 Y117.311
G1 X102.417 Y128.386 E.46653
G1 X102.417 Y127.853
G1 X112.959 Y117.311 E.44407
G1 X112.426 Y117.311
G1 X102.417 Y127.319 E.42161
G1 X102.417 Y126.786
G1 X111.893 Y117.311 E.39914
G1 X111.359 Y117.311
G1 X102.417 Y126.253 E.37668
G1 X102.417 Y125.72
G1 X110.826 Y117.311 E.35422
G1 X110.293 Y117.311
G1 X102.417 Y125.186 E.33175
G1 X102.417 Y124.653
G1 X109.76 Y117.311 E.30929
M73 P98 R0
G1 X109.226 Y117.311
G1 X102.417 Y124.12 E.28683
G1 X102.417 Y123.587
G1 X108.693 Y117.311 E.26436
G1 X108.16 Y117.311
G1 X102.417 Y123.053 E.2419
G1 X102.417 Y122.52
G1 X107.627 Y117.311 E.21944
G1 X107.093 Y117.311
G1 X102.417 Y121.987 E.19698
G1 X102.417 Y121.454
G1 X106.56 Y117.311 E.17451
G1 X106.027 Y117.311
G1 X102.417 Y120.92 E.15205
G1 X102.417 Y120.387
G1 X105.494 Y117.311 E.12959
G1 X104.96 Y117.311
G1 X102.417 Y119.854 E.10712
G1 X102.417 Y119.32
G1 X104.427 Y117.311 E.08466
G1 X103.894 Y117.311
G1 X102.417 Y118.787 E.0622
G1 X102.417 Y118.254
G1 X103.361 Y117.311 E.03973
G1 X102.827 Y117.311
G1 X102.417 Y117.721 E.01727
; WIPE_START
M204 S10000
G1 X102.827 Y117.311 E-.22031
G1 X103.361 Y117.311 E-.20264
G1 X102.733 Y117.938 E-.33706
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.196 J1.201 P1  F30000
G1 X141.905 Y124.331 Z4.8
G1 Z4.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.101341
G1 F15000
G1 X141.809 Y124.407 E.00056
; LINE_WIDTH: 0.137449
G3 X141.524 Y124.616 I-2.206 J-2.707 E.00265
; WIPE_START
G1 X141.809 Y124.407 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I.898 J.822 P1  F30000
G1 X142.625 Y123.515 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.137214
G1 F15000
G1 X142.482 Y123.717 E.00185
; LINE_WIDTH: 0.11209
G1 X142.356 Y123.881 E.00113
G1 X142.599 Y123.665 F30000
; LINE_WIDTH: 0.0941652
G1 F15000
G1 X142.541 Y123.431 E.00098
; WIPE_START
G1 X142.599 Y123.665 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.542 Y123.701 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.0906781
G1 F15000
G1 X139.472 Y123.594 E.00048
; WIPE_START
G1 X139.542 Y123.701 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.019 J-1.217 P1  F30000
G1 X129.465 Y123.857 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.204638
G1 F15000
G1 X129.398 Y123.945 E.00142
G3 X128.876 Y124.446 I-2.486 J-2.068 E.00925
; WIPE_START
G1 X129.046 Y124.311 E-.19764
G1 X129.398 Y123.945 E-.46134
G1 X129.465 Y123.857 E-.10102
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I1.165 J.352 P1  F30000
G1 X129.687 Y123.124 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.131713
G1 F15000
G1 X129.58 Y123.335 E.00166
; WIPE_START
G1 X129.687 Y123.124 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I.72 J-.981 P1  F30000
G1 X127.378 Y121.43 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.199117
G1 F15000
G1 X127.274 Y121.497 E.00153
; LINE_WIDTH: 0.168052
G1 X127.132 Y121.609 E.00178
; LINE_WIDTH: 0.124433
G1 X126.986 Y121.724 E.0012
; LINE_WIDTH: 0.10291
G1 X126.644 Y122.079 E.00234
; LINE_WIDTH: 0.137567
G1 X126.571 Y122.175 E.0009
; LINE_WIDTH: 0.178573
G2 X126.415 Y122.387 I2.705 J2.152 E.00283
; WIPE_START
G1 X126.571 Y122.175 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I-.143 J-1.209 P1  F30000
G1 X116.662 Y123.345 Z4.8
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.144418
G1 F15000
G1 X116.495 Y123.623 E.0026
; WIPE_START
G1 X116.662 Y123.345 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.503 Y122.384 Z4.8 F30000
G1 Z4.4
G1 E.8 F1800
; LINE_WIDTH: 0.141087
G1 F15000
G1 X113.337 Y122.66 E.0025
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F15000
G1 X113.503 Y122.384 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I1.217 J0 P1  F30000
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20230428 =====================
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
G1 Z4.9 F900 ; lower z a little
G1 X65 Y245 F12000 ; move to safe pos 
G1 Y265 F3000

G1 X65 Y245 F12000
G1 Y265 F3000
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

G1 X100 F12000 ; wipe
; pull back filament to AMS
M620 S255
G1 X20 Y50 F12000
G1 Y-3
T255
G1 X65 F12000
G1 Y265
G1 X100 F12000 ; wipe
M621 S255
M104 S0 ; turn off hotend

M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S3 ;wait for last picture to be taken
M623; end of "timelapse_record_flag"

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z104.4 F600
    G1 Z102.4

M400 P100
M17 R ; restore z current

G90
G1 X128 Y250 F3600

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M73 P100 R0
; EXECUTABLE_BLOCK_END

