M109 S210.000000
M107
G28 X0 Y0 Z0
G29 ; initiate z-probing
G0 X0 Y0 F9000 ; Go to front
G0 Z0.15 ; Drop to bed
G92 E0 ; zero the extruded length
G1 X40 E25 F500 ; Extrude 25mm of filament in a 4cm line
G92 E0 ; zero the extruded length
G1 E-1 F500 ; Retract a little
G1 X80 F4000 ; Quickly wipe away from the filament line
G1 Z0.3 ; Raise and begin printing.

;Layer count: 15
;LAYER:0
M107
G0 F4200 X61.400 Y61.400 Z0.300
;TYPE:SKIRT
G1 F2100 X88.600 Y61.400 E1.35701
G1 X88.600 Y88.600 E2.71403
G1 X61.400 Y88.600 E4.07104
G1 X61.400 Y61.400 E5.42805
G0 F4200 X61.800 Y61.800
G1 F2100 X88.200 Y61.800 E6.74516
G1 X88.200 Y88.200 E8.06226
G1 X61.800 Y88.200 E9.37936
G1 X61.800 Y61.800 E10.69646
G1 F2400 E9.69646
G0 F4200 X65.600 Y65.600
;TYPE:WALL-INNER
G1 F2400 E10.69646
G1 F2100 X84.400 Y65.600 E11.63440
G1 X84.400 Y84.400 E12.57233
G1 X65.600 Y84.400 E13.51027
G1 X65.600 Y65.600 E14.44820
G0 F4200 X65.200 Y65.200
;TYPE:WALL-OUTER
G1 F2100 X84.800 Y65.200 E15.42605
G1 X84.800 Y84.800 E16.40390
G1 X65.200 Y84.800 E17.38175
G1 X65.200 Y65.200 E18.35959
G0 F4200 X65.739 Y66.022
;TYPE:SKIN
G1 F2100 X83.976 Y84.259 E19.64631
G0 F4200 X84.259 Y83.976
G1 F2100 X66.023 Y65.740 E20.93296
G0 F4200 X66.588 Y65.740
G1 F2100 X84.259 Y83.411 E22.17975
G0 F4200 X84.259 Y82.845
G1 F2100 X67.154 Y65.740 E23.38660
G0 F4200 X67.720 Y65.740
G1 F2100 X84.259 Y82.279 E24.55351
G0 F4200 X84.259 Y81.713
G1 F2100 X68.286 Y65.740 E25.68049
G0 F4200 X68.851 Y65.740
G1 F2100 X84.259 Y81.148 E26.76761
G0 F4200 X84.259 Y80.582
G1 F2100 X69.417 Y65.740 E27.81479
G0 F4200 X69.983 Y65.740
G1 F2100 X84.259 Y80.016 E28.82204
G1 F2400 E27.82204
G0 F4200 X83.411 Y84.259
G1 F2400 E28.82204
G1 F2100 X65.739 Y66.588 E30.06886
G0 F4200 X65.739 Y67.153
G1 F2100 X82.845 Y84.259 E31.27578
G0 F4200 X82.279 Y84.259
G1 F2100 X65.739 Y67.719 E32.44277
G0 F4200 X65.739 Y68.285
G1 F2100 X81.713 Y84.259 E33.56982
G0 F4200 X81.148 Y84.259
G1 F2100 X65.739 Y68.850 E34.65701
G0 F4200 X65.739 Y69.416
G1 F2100 X80.582 Y84.259 E35.70426
G0 F4200 X80.016 Y84.259
G1 F2100 X65.739 Y69.982 E36.71158
G0 F4200 X65.739 Y70.548
G1 F2100 X79.451 Y84.259 E37.67900
G0 F4200 X78.885 Y84.259
G1 F2100 X65.739 Y71.113 E38.60653
G0 F4200 X65.739 Y71.679
G1 F2100 X78.319 Y84.259 E39.49411
G0 F4200 X77.754 Y84.259
G1 F2100 X65.739 Y72.245 E40.34180
G0 F4200 X65.739 Y72.810
G1 F2100 X77.188 Y84.259 E41.14959
G0 F4200 X76.622 Y84.259
G1 F2100 X65.739 Y73.376 E41.91744
G0 F4200 X65.739 Y73.942
G1 F2100 X76.057 Y84.259 E42.64540
G0 F4200 X75.491 Y84.259
G1 F2100 X65.739 Y74.507 E43.33345
G0 F4200 X65.739 Y75.073
G1 F2100 X74.925 Y84.259 E43.98158
G0 F4200 X74.360 Y84.259
G1 F2100 X65.739 Y75.639 E44.58980
G0 F4200 X65.739 Y76.204
G1 F2100 X73.794 Y84.259 E45.15812
G0 F4200 X73.228 Y84.259
G1 F2100 X65.739 Y76.770 E45.68651
G0 F4200 X65.739 Y77.336
G1 F2100 X72.662 Y84.259 E46.17497
G0 F4200 X72.097 Y84.259
G1 F2100 X65.739 Y77.901 E46.62356
G0 F4200 X65.739 Y78.467
G1 F2100 X71.531 Y84.259 E47.03222
G0 F4200 X70.965 Y84.259
G1 F2100 X65.739 Y79.033 E47.40094
G0 F4200 X65.739 Y79.599
G1 F2100 X70.400 Y84.259 E47.72976
G0 F4200 X69.834 Y84.259
G1 F2100 X65.739 Y80.164 E48.01869
G0 F4200 X65.739 Y80.730
G1 F2100 X69.268 Y84.259 E48.26768
G0 F4200 X68.703 Y84.259
G1 F2100 X65.739 Y81.296 E48.47677
G0 F4200 X65.739 Y81.861
G1 F2100 X68.137 Y84.259 E48.64596
G0 F4200 X67.571 Y84.259
G1 F2100 X65.739 Y82.427 E48.77522
G0 F4200 X65.739 Y82.993
G1 F2100 X67.006 Y84.259 E48.86458
G0 F4200 X66.440 Y84.259
G1 F2100 X65.739 Y83.558 E48.91403
G0 F4200 X65.739 Y84.124
G1 F2100 X65.874 Y84.259 E48.92356
G1 F2400 E47.92356
G0 F4200 X84.259 Y79.451
G1 F2400 E48.92356
G1 F2100 X70.548 Y65.740 E49.89094
G0 F4200 X71.114 Y65.740
G1 F2100 X84.259 Y78.885 E50.81840
G0 F4200 X84.259 Y78.319
G1 F2100 X71.680 Y65.740 E51.70591
G0 F4200 X72.245 Y65.740
G1 F2100 X84.259 Y77.754 E52.55356
G0 F4200 X84.259 Y77.188
G1 F2100 X72.811 Y65.740 E53.36128
G0 F4200 X73.377 Y65.740
G1 F2100 X84.259 Y76.622 E54.12907
G0 F4200 X84.259 Y76.057
G1 F2100 X73.942 Y65.740 E54.85699
G0 F4200 X74.508 Y65.740
G1 F2100 X84.259 Y75.491 E55.54497
G0 F4200 X84.259 Y74.925
G1 F2100 X75.074 Y65.740 E56.19302
G0 F4200 X75.639 Y65.740
G1 F2100 X84.259 Y74.360 E56.80121
G0 F4200 X84.259 Y73.794
G1 F2100 X76.205 Y65.740 E57.36946
G0 F4200 X76.771 Y65.740
G1 F2100 X84.259 Y73.228 E57.89778
G0 F4200 X84.259 Y72.662
G1 F2100 X77.336 Y65.740 E58.38620
G0 F4200 X77.902 Y65.740
G1 F2100 X84.259 Y72.097 E58.83472
G0 F4200 X84.259 Y71.531
G1 F2100 X78.468 Y65.740 E59.24331
G0 F4200 X79.034 Y65.740
G1 F2100 X84.259 Y70.965 E59.61196
G0 F4200 X84.259 Y70.400
G1 F2100 X79.599 Y65.740 E59.94075
G0 F4200 X80.165 Y65.740
G1 F2100 X84.259 Y69.834 E60.22960
G0 F4200 X84.259 Y69.268
G1 F2100 X80.731 Y65.740 E60.47852
G0 F4200 X81.296 Y65.740
G1 F2100 X84.259 Y68.703 E60.68758
G0 F4200 X84.259 Y68.137
G1 F2100 X81.862 Y65.740 E60.85670
G0 F4200 X82.428 Y65.740
G1 F2100 X84.259 Y67.571 E60.98589
G0 F4200 X84.259 Y67.006
G1 F2100 X82.993 Y65.740 E61.07521
G0 F4200 X83.559 Y65.740
G1 F2100 X84.259 Y66.440 E61.12460
G0 F4200 X84.259 Y65.874
G1 F2100 X84.125 Y65.740 E61.13405
;LAYER:1
M106 S127
G0 F4200 X84.400 Y65.600 Z0.498
;TYPE:WALL-INNER
G1 F2220 X84.400 Y84.400 E61.75309
G1 X65.600 Y84.400 E62.37213
G1 X65.600 Y65.600 E62.99117
G1 X84.400 Y65.600 E63.61020
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2220 X84.800 Y84.800 E64.25558
G1 X65.200 Y84.800 E64.90096
G1 X65.200 Y65.200 E65.54634
G1 X84.800 Y65.200 E66.19172
G0 F4200 X84.259 Y65.929
;TYPE:SKIN
G1 F2220 X65.929 Y84.259 E67.04529
G0 F4200 X65.740 Y83.883
G1 F2220 X83.884 Y65.739 E67.89019
G0 F4200 X83.318 Y65.739
G1 F2220 X65.740 Y83.317 E68.70874
G0 F4200 X65.740 Y82.751
G1 F2220 X82.752 Y65.739 E69.50093
G0 F4200 X82.187 Y65.739
G1 F2220 X65.740 Y82.186 E70.26681
G0 F4200 X65.740 Y81.620
G1 F2220 X81.621 Y65.739 E71.00633
G0 F4200 X81.055 Y65.739
G1 F2220 X65.740 Y81.054 E71.71950
G0 F4200 X65.740 Y80.489
G1 F2220 X80.489 Y65.739 E72.40633
G0 F4200 X84.259 Y66.495
G1 F2220 X66.495 Y84.259 E73.23354
G0 F4200 X67.061 Y84.259
G1 F2220 X84.259 Y67.061 E74.03439
G0 F4200 X84.259 Y67.626
G1 F2220 X67.626 Y84.259 E74.80894
G0 F4200 X68.192 Y84.259
G1 F2220 X84.259 Y68.192 E75.55712
G0 F4200 X84.259 Y68.758
G1 F2220 X68.758 Y84.259 E76.27895
G0 F4200 X69.324 Y84.259
G1 F2220 X84.259 Y69.324 E76.97442
G0 F4200 X84.259 Y69.889
G1 F2220 X69.889 Y84.259 E77.64358
G0 F4200 X70.455 Y84.259
G1 F2220 X84.259 Y70.455 E78.28639
G0 F4200 X84.259 Y71.021
G1 F2220 X71.021 Y84.259 E78.90283
G0 F4200 X71.586 Y84.259
G1 F2220 X84.259 Y71.586 E79.49297
G0 F4200 X84.259 Y72.152
G1 F2220 X72.152 Y84.259 E80.05675
G0 F4200 X72.718 Y84.259
G1 F2220 X84.259 Y72.718 E80.59418
G0 F4200 X84.259 Y73.283
G1 F2220 X73.283 Y84.259 E81.10529
G0 F4200 X73.849 Y84.259
G1 F2220 X84.259 Y73.849 E81.59005
G0 F4200 X84.259 Y74.415
G1 F2220 X74.415 Y84.259 E82.04845
G0 F4200 X74.980 Y84.259
G1 F2220 X84.259 Y74.980 E82.48054
G0 F4200 X84.259 Y75.546
G1 F2220 X75.546 Y84.259 E82.88628
G0 F4200 X76.112 Y84.259
G1 F2220 X84.259 Y76.112 E83.26566
G0 F4200 X84.259 Y76.677
G1 F2220 X76.677 Y84.259 E83.61872
G0 F4200 X77.243 Y84.259
G1 F2220 X84.259 Y77.243 E83.94543
G0 F4200 X84.259 Y77.809
G1 F2220 X77.809 Y84.259 E84.24579
G0 F4200 X78.375 Y84.259
G1 F2220 X84.259 Y78.375 E84.51979
G0 F4200 X84.259 Y78.940
G1 F2220 X78.940 Y84.259 E84.76747
G0 F4200 X79.506 Y84.259
G1 F2220 X84.259 Y79.506 E84.98881
G0 F4200 X84.259 Y80.072
G1 F2220 X80.072 Y84.259 E85.18378
G0 F4200 X80.637 Y84.259
G1 F2220 X84.259 Y80.637 E85.35244
G0 F4200 X84.259 Y81.203
G1 F2220 X81.203 Y84.259 E85.49475
G0 F4200 X81.769 Y84.259
G1 F2220 X84.259 Y81.769 E85.61070
G0 F4200 X84.259 Y82.334
G1 F2220 X82.334 Y84.259 E85.70034
G0 F4200 X82.900 Y84.259
G1 F2220 X84.259 Y82.900 E85.76363
G0 F4200 X84.259 Y83.466
G1 F2220 X83.466 Y84.259 E85.80055
G0 F4200 X84.031 Y84.259
G1 F2220 X84.259 Y84.031 E85.81117
G1 F2400 E84.81117
G0 F4200 X79.924 Y65.739
G1 F2400 E85.81117
G1 F2220 X65.740 Y79.923 E86.47167
G0 F4200 X65.740 Y79.357
G1 F2220 X79.358 Y65.739 E87.10581
G0 F4200 X78.792 Y65.739
G1 F2220 X65.740 Y78.792 E87.71362
G0 F4200 X65.740 Y78.226
G1 F2220 X78.227 Y65.739 E88.29510
G0 F4200 X77.661 Y65.739
G1 F2220 X65.740 Y77.660 E88.85022
G0 F4200 X65.740 Y77.095
G1 F2220 X77.095 Y65.739 E89.37901
G0 F4200 X76.530 Y65.739
G1 F2220 X65.740 Y76.529 E89.88146
G0 F4200 X65.740 Y75.963
G1 F2220 X75.964 Y65.739 E90.35756
G0 F4200 X75.398 Y65.739
G1 F2220 X65.740 Y75.398 E90.80732
G0 F4200 X65.740 Y74.832
G1 F2220 X74.833 Y65.739 E91.23075
G0 F4200 X74.267 Y65.739
G1 F2220 X65.740 Y74.266 E91.62782
G0 F4200 X65.740 Y73.701
G1 F2220 X73.701 Y65.739 E91.99856
G0 F4200 X73.136 Y65.739
G1 F2220 X65.740 Y73.135 E92.34297
G0 F4200 X65.740 Y72.569
G1 F2220 X72.570 Y65.739 E92.66102
G0 F4200 X72.004 Y65.739
G1 F2220 X65.740 Y72.003 E92.95271
G0 F4200 X65.740 Y71.438
G1 F2220 X71.438 Y65.739 E93.21807
G0 F4200 X70.873 Y65.739
G1 F2220 X65.740 Y70.872 E93.45710
G0 F4200 X65.740 Y70.306
G1 F2220 X70.307 Y65.739 E93.66977
G0 F4200 X69.741 Y65.739
G1 F2220 X65.740 Y69.741 E93.85610
G0 F4200 X65.740 Y69.175
G1 F2220 X69.176 Y65.739 E94.01611
G0 F4200 X68.610 Y65.739
G1 F2220 X65.740 Y68.609 E94.14975
G0 F4200 X65.740 Y68.044
G1 F2220 X68.044 Y65.739 E94.25707
G0 F4200 X67.479 Y65.739
G1 F2220 X65.740 Y67.478 E94.33804
G0 F4200 X65.740 Y66.912
G1 F2220 X66.913 Y65.739 E94.39267
G0 F4200 X66.347 Y65.739
G1 F2220 X65.740 Y66.347 E94.42096
;LAYER:2
M106 S255
G0 F4200 X65.600 Y65.600 Z0.696
;TYPE:WALL-INNER
G1 F2340 X84.400 Y65.600 E95.03999
G1 X84.400 Y84.400 E95.65903
G1 X65.600 Y84.400 E96.27807
G1 X65.600 Y65.600 E96.89711
G0 F4200 X65.200 Y65.200
;TYPE:WALL-OUTER
G1 F2340 X84.800 Y65.200 E97.54249
G1 X84.800 Y84.800 E98.18787
G1 X65.200 Y84.800 E98.83325
G1 X65.200 Y65.200 E99.47863
G0 F4200 X65.739 Y66.022
;TYPE:SKIN
G1 F2340 X83.976 Y84.259 E100.32786
G0 F4200 X84.259 Y83.976
G1 F2340 X66.023 Y65.740 E101.17705
G0 F4200 X66.588 Y65.740
G1 F2340 X84.259 Y83.411 E101.99993
G0 F4200 X84.259 Y82.845
G1 F2340 X67.154 Y65.740 E102.79645
G0 F4200 X67.720 Y65.740
G1 F2340 X84.259 Y82.279 E103.56661
G0 F4200 X84.259 Y81.713
G1 F2340 X68.286 Y65.740 E104.31042
G0 F4200 X68.851 Y65.740
G1 F2340 X84.259 Y81.148 E105.02792
G0 F4200 X84.259 Y80.582
G1 F2340 X69.417 Y65.740 E105.71906
G0 F4200 X69.983 Y65.740
G1 F2340 X84.259 Y80.016 E106.38384
G1 F2400 E105.38384
G0 F4200 X83.411 Y84.259
G1 F2400 E106.38384
G1 F2340 X65.739 Y66.588 E107.20674
G0 F4200 X65.739 Y67.153
G1 F2340 X82.845 Y84.259 E108.00331
G0 F4200 X82.279 Y84.259
G1 F2340 X65.739 Y67.719 E108.77352
G0 F4200 X65.739 Y68.285
G1 F2340 X81.713 Y84.259 E109.51738
G0 F4200 X81.148 Y84.259
G1 F2340 X65.739 Y68.850 E110.23492
G0 F4200 X65.739 Y69.416
G1 F2340 X80.582 Y84.259 E110.92611
G0 F4200 X80.016 Y84.259
G1 F2340 X65.739 Y69.982 E111.59094
G0 F4200 X65.739 Y70.548
G1 F2340 X79.451 Y84.259 E112.22944
G0 F4200 X78.885 Y84.259
G1 F2340 X65.739 Y71.113 E112.84160
G0 F4200 X65.739 Y71.679
G1 F2340 X78.319 Y84.259 E113.42741
G0 F4200 X77.754 Y84.259
G1 F2340 X65.739 Y72.245 E113.98688
G0 F4200 X65.739 Y72.810
G1 F2340 X77.188 Y84.259 E114.52002
G0 F4200 X76.622 Y84.259
G1 F2340 X65.739 Y73.376 E115.02681
G0 F4200 X65.739 Y73.942
G1 F2340 X76.057 Y84.259 E115.50726
G0 F4200 X75.491 Y84.259
G1 F2340 X65.739 Y74.507 E115.96137
G0 F4200 X65.739 Y75.073
G1 F2340 X74.925 Y84.259 E116.38913
G0 F4200 X74.360 Y84.259
G1 F2340 X65.739 Y75.639 E116.79056
G0 F4200 X65.739 Y76.204
G1 F2340 X73.794 Y84.259 E117.16565
G0 F4200 X73.228 Y84.259
G1 F2340 X65.739 Y76.770 E117.51439
G0 F4200 X65.739 Y77.336
G1 F2340 X72.662 Y84.259 E117.83677
G0 F4200 X72.097 Y84.259
G1 F2340 X65.739 Y77.901 E118.13284
G0 F4200 X65.739 Y78.467
G1 F2340 X71.531 Y84.259 E118.40256
G0 F4200 X70.965 Y84.259
G1 F2340 X65.739 Y79.033 E118.64591
G0 F4200 X65.739 Y79.599
G1 F2340 X70.400 Y84.259 E118.86294
G0 F4200 X69.834 Y84.259
G1 F2340 X65.739 Y80.164 E119.05363
G0 F4200 X65.739 Y80.730
G1 F2340 X69.268 Y84.259 E119.21796
G0 F4200 X68.703 Y84.259
G1 F2340 X65.739 Y81.296 E119.35596
G0 F4200 X65.739 Y81.861
G1 F2340 X68.137 Y84.259 E119.46763
G0 F4200 X67.571 Y84.259
G1 F2340 X65.739 Y82.427 E119.55294
G0 F4200 X65.739 Y82.993
G1 F2340 X67.006 Y84.259 E119.61191
G0 F4200 X66.440 Y84.259
G1 F2340 X65.739 Y83.558 E119.64456
G0 F4200 X65.739 Y84.124
G1 F2340 X65.874 Y84.259 E119.65084
G1 F2400 E118.65084
G0 F4200 X84.259 Y79.451
G1 F2400 E119.65084
G1 F2340 X70.548 Y65.740 E120.28932
G0 F4200 X71.114 Y65.740
G1 F2340 X84.259 Y78.885 E120.90143
G0 F4200 X84.259 Y78.319
G1 F2340 X71.680 Y65.740 E121.48719
G0 F4200 X72.245 Y65.740
G1 F2340 X84.259 Y77.754 E122.04665
G0 F4200 X84.259 Y77.188
G1 F2340 X72.811 Y65.740 E122.57974
G0 F4200 X73.377 Y65.740
G1 F2340 X84.259 Y76.622 E123.08648
G0 F4200 X84.259 Y76.057
G1 F2340 X73.942 Y65.740 E123.56690
G0 F4200 X74.508 Y65.740
G1 F2340 X84.259 Y75.491 E124.02097
G0 F4200 X84.259 Y74.925
G1 F2340 X75.074 Y65.740 E124.44869
G0 F4200 X75.639 Y65.740
G1 F2340 X84.259 Y74.360 E124.85009
G0 F4200 X84.259 Y73.794
G1 F2340 X76.205 Y65.740 E125.22514
G0 F4200 X76.771 Y65.740
G1 F2340 X84.259 Y73.228 E125.57383
G0 F4200 X84.259 Y72.662
G1 F2340 X77.336 Y65.740 E125.89619
G0 F4200 X77.902 Y65.740
G1 F2340 X84.259 Y72.097 E126.19221
G0 F4200 X84.259 Y71.531
G1 F2340 X78.468 Y65.740 E126.46188
G0 F4200 X79.034 Y65.740
G1 F2340 X84.259 Y70.965 E126.70519
G0 F4200 X84.259 Y70.400
G1 F2340 X79.599 Y65.740 E126.92219
G0 F4200 X80.165 Y65.740
G1 F2340 X84.259 Y69.834 E127.11283
G0 F4200 X84.259 Y69.268
G1 F2340 X80.731 Y65.740 E127.27712
G0 F4200 X81.296 Y65.740
G1 F2340 X84.259 Y68.703 E127.41510
G0 F4200 X84.259 Y68.137
G1 F2340 X81.862 Y65.740 E127.52672
G0 F4200 X82.428 Y65.740
G1 F2340 X84.259 Y67.571 E127.61198
G0 F4200 X84.259 Y67.006
G1 F2340 X82.993 Y65.740 E127.67093
G0 F4200 X83.559 Y65.740
G1 F2340 X84.259 Y66.440 E127.70353
G0 F4200 X84.259 Y65.874
G1 F2340 X84.125 Y65.740 E127.70977
;LAYER:3
G0 F4200 X84.400 Y65.600 Z0.894
;TYPE:WALL-INNER
G1 F2460 X84.400 Y84.400 E128.32881
G1 X65.600 Y84.400 E128.94784
G1 X65.600 Y65.600 E129.56688
G1 X84.400 Y65.600 E130.18592
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2460 X84.800 Y84.800 E130.83130
G1 X65.200 Y84.800 E131.47668
G1 X65.200 Y65.200 E132.12206
G1 X84.800 Y65.200 E132.76744
G0 F4200 X81.301 Y65.739
;TYPE:FILL
G1 F2460 X65.740 Y81.301 E133.49208
G1 F2400 E132.49208
G0 F4200 X65.739 Y77.050
G1 F2400 E133.49208
G1 F2460 X72.948 Y84.259 E133.82778
G0 F4200 X70.322 Y84.259
G1 F2460 X84.259 Y70.322 E134.47678
G0 F4200 X84.259 Y72.948
G1 F2460 X77.051 Y65.740 E134.81243
G0 F4200 X73.761 Y65.739
G1 F2460 X65.740 Y73.760 E135.18594
G1 F2400 E134.18594
G0 F4200 X65.739 Y69.510
G1 F2400 E135.18594
G1 F2460 X80.489 Y84.259 E135.87278
G1 F2400 E134.87278
G0 F4200 X84.259 Y80.489
G1 F2400 E135.87278
G1 F2460 X69.510 Y65.740 E136.55959
G0 F4200 X66.220 Y65.739
G1 F2460 X65.740 Y66.219 E136.58194
G1 F2400 E135.58194
G0 F4200 X77.863 Y84.259
G1 F2400 E136.58194
G1 F2460 X84.259 Y77.863 E136.87978
;LAYER:4
G1 F2400 E135.87978
G0 F4200 X84.400 Y84.400 Z1.092
;TYPE:WALL-INNER
G1 F2400 E136.87978
G1 F2700 X65.600 Y84.400 E137.49881
G1 X65.600 Y65.600 E138.11785
G1 X84.400 Y65.600 E138.73689
G1 X84.400 Y84.400 E139.35593
G0 F4200 X84.800 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y84.800 E140.00131
G1 X65.200 Y65.200 E140.64669
G1 X84.800 Y65.200 E141.29207
G1 X84.800 Y84.800 E141.93745
G1 F2400 E140.93745
G0 F4200 X80.489 Y84.259
;TYPE:FILL
G1 F2400 E141.93745
G1 F2700 X65.739 Y69.510 E142.62428
G0 F4200 X65.740 Y66.219
G1 F2700 X66.220 Y65.739 E142.64663
G0 F4200 X69.510 Y65.740
G1 F2700 X84.259 Y80.489 E143.33344
G0 F4200 X84.259 Y77.863
G1 F2700 X77.863 Y84.259 E143.63128
G1 F2400 E142.63128
G0 F4200 X72.948 Y84.259
G1 F2400 E143.63128
G1 F2700 X65.739 Y77.050 E143.96698
G0 F4200 X65.740 Y73.760
G1 F2700 X73.761 Y65.739 E144.34049
G0 F4200 X77.051 Y65.740
G1 F2700 X84.259 Y72.948 E144.67614
G0 F4200 X84.259 Y70.322
G1 F2700 X70.322 Y84.259 E145.32514
G1 F2400 E144.32514
G0 F4200 X65.740 Y81.301
G1 F2400 E145.32514
G1 F2700 X81.301 Y65.739 E146.04979
;LAYER:5
G0 F4200 X84.400 Y65.600 Z1.290
;TYPE:WALL-INNER
G1 F2700 X84.400 Y84.400 E146.66882
G1 X65.600 Y84.400 E147.28786
G1 X65.600 Y65.600 E147.90690
G1 X84.400 Y65.600 E148.52594
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2700 X84.800 Y84.800 E149.17132
G1 X65.200 Y84.800 E149.81670
G1 X65.200 Y65.200 E150.46208
G1 X84.800 Y65.200 E151.10746
G0 F4200 X81.301 Y65.739
;TYPE:FILL
G1 F2700 X65.740 Y81.301 E151.83210
G1 F2400 E150.83210
G0 F4200 X65.739 Y77.050
G1 F2400 E151.83210
G1 F2700 X72.948 Y84.259 E152.16780
G0 F4200 X70.322 Y84.259
G1 F2700 X84.259 Y70.322 E152.81680
G0 F4200 X84.259 Y72.948
G1 F2700 X77.051 Y65.740 E153.15245
G0 F4200 X73.761 Y65.739
G1 F2700 X65.740 Y73.760 E153.52596
G1 F2400 E152.52596
G0 F4200 X65.739 Y69.510
G1 F2400 E153.52596
G1 F2700 X80.489 Y84.259 E154.21279
G1 F2400 E153.21279
G0 F4200 X84.259 Y80.489
G1 F2400 E154.21279
G1 F2700 X69.510 Y65.740 E154.89960
G0 F4200 X66.220 Y65.739
G1 F2700 X65.740 Y66.219 E154.92196
G1 F2400 E153.92196
G0 F4200 X77.863 Y84.259
G1 F2400 E154.92196
G1 F2700 X84.259 Y77.863 E155.21980
;LAYER:6
G1 F2400 E154.21980
G0 F4200 X84.400 Y84.400 Z1.488
;TYPE:WALL-INNER
G1 F2400 E155.21980
G1 F2700 X65.600 Y84.400 E155.83883
G1 X65.600 Y65.600 E156.45787
G1 X84.400 Y65.600 E157.07691
G1 X84.400 Y84.400 E157.69595
G0 F4200 X84.800 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y84.800 E158.34133
G1 X65.200 Y65.200 E158.98671
G1 X84.800 Y65.200 E159.63209
G1 X84.800 Y84.800 E160.27746
G1 F2400 E159.27746
G0 F4200 X80.489 Y84.259
;TYPE:FILL
G1 F2400 E160.27746
G1 F2700 X65.739 Y69.510 E160.96430
G0 F4200 X65.740 Y66.219
G1 F2700 X66.220 Y65.739 E160.98665
G0 F4200 X69.510 Y65.740
G1 F2700 X84.259 Y80.489 E161.67346
G0 F4200 X84.259 Y77.863
G1 F2700 X77.863 Y84.259 E161.97130
G1 F2400 E160.97130
G0 F4200 X72.948 Y84.259
G1 F2400 E161.97130
G1 F2700 X65.739 Y77.050 E162.30700
G0 F4200 X65.740 Y73.760
G1 F2700 X73.761 Y65.739 E162.68051
G0 F4200 X77.051 Y65.740
G1 F2700 X84.259 Y72.948 E163.01616
G0 F4200 X84.259 Y70.322
G1 F2700 X70.322 Y84.259 E163.66516
G1 F2400 E162.66516
G0 F4200 X65.740 Y81.301
G1 F2400 E163.66516
G1 F2700 X81.301 Y65.739 E164.38980
;LAYER:7
G0 F4200 X84.400 Y65.600 Z1.686
;TYPE:WALL-INNER
G1 F2700 X84.400 Y84.400 E165.00884
G1 X65.600 Y84.400 E165.62788
G1 X65.600 Y65.600 E166.24692
G1 X84.400 Y65.600 E166.86596
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2700 X84.800 Y84.800 E167.51133
G1 X65.200 Y84.800 E168.15671
G1 X65.200 Y65.200 E168.80209
G1 X84.800 Y65.200 E169.44747
G0 F4200 X81.301 Y65.739
;TYPE:FILL
G1 F2700 X65.740 Y81.301 E170.17212
G1 F2400 E169.17212
G0 F4200 X65.739 Y77.050
G1 F2400 E170.17212
G1 F2700 X72.948 Y84.259 E170.50782
G0 F4200 X70.322 Y84.259
G1 F2700 X84.259 Y70.322 E171.15682
G0 F4200 X84.259 Y72.948
G1 F2700 X77.051 Y65.740 E171.49247
G0 F4200 X73.761 Y65.739
G1 F2700 X65.740 Y73.760 E171.86598
G1 F2400 E170.86598
G0 F4200 X65.739 Y69.510
G1 F2400 E171.86598
G1 F2700 X80.489 Y84.259 E172.55281
G1 F2400 E171.55281
G0 F4200 X84.259 Y80.489
G1 F2400 E172.55281
G1 F2700 X69.510 Y65.740 E173.23962
G0 F4200 X66.220 Y65.739
G1 F2700 X65.740 Y66.219 E173.26197
G1 F2400 E172.26197
G0 F4200 X77.863 Y84.259
G1 F2400 E173.26197
G1 F2700 X84.259 Y77.863 E173.55981
;LAYER:8
G1 F2400 E172.55981
G0 F4200 X84.400 Y84.400 Z1.884
;TYPE:WALL-INNER
G1 F2400 E173.55981
G1 F2700 X65.600 Y84.400 E174.17885
G1 X65.600 Y65.600 E174.79789
G1 X84.400 Y65.600 E175.41693
G1 X84.400 Y84.400 E176.03596
G0 F4200 X84.800 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y84.800 E176.68134
G1 X65.200 Y65.200 E177.32672
G1 X84.800 Y65.200 E177.97210
G1 X84.800 Y84.800 E178.61748
G1 F2400 E177.61748
G0 F4200 X80.489 Y84.259
;TYPE:FILL
G1 F2400 E178.61748
G1 F2700 X65.739 Y69.510 E179.30432
G0 F4200 X65.740 Y66.219
G1 F2700 X66.220 Y65.739 E179.32667
G0 F4200 X69.510 Y65.740
G1 F2700 X84.259 Y80.489 E180.01348
G0 F4200 X84.259 Y77.863
G1 F2700 X77.863 Y84.259 E180.31132
G1 F2400 E179.31132
G0 F4200 X72.948 Y84.259
G1 F2400 E180.31132
G1 F2700 X65.739 Y77.050 E180.64702
G0 F4200 X65.740 Y73.760
G1 F2700 X73.761 Y65.739 E181.02053
G0 F4200 X77.051 Y65.740
G1 F2700 X84.259 Y72.948 E181.35618
G0 F4200 X84.259 Y70.322
G1 F2700 X70.322 Y84.259 E182.00518
G1 F2400 E181.00518
G0 F4200 X65.740 Y81.301
G1 F2400 E182.00518
G1 F2700 X81.301 Y65.739 E182.72982
;LAYER:9
G0 F4200 X84.400 Y65.600 Z2.082
;TYPE:WALL-INNER
G1 F2700 X84.400 Y84.400 E183.34886
G1 X65.600 Y84.400 E183.96790
G1 X65.600 Y65.600 E184.58694
G1 X84.400 Y65.600 E185.20597
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2700 X84.800 Y84.800 E185.85135
G1 X65.200 Y84.800 E186.49673
G1 X65.200 Y65.200 E187.14211
G1 X84.800 Y65.200 E187.78749
G0 F4200 X81.301 Y65.739
;TYPE:FILL
G1 F2700 X65.740 Y81.301 E188.51214
G1 F2400 E187.51214
G0 F4200 X65.739 Y77.050
G1 F2400 E188.51214
G1 F2700 X72.948 Y84.259 E188.84784
G0 F4200 X70.322 Y84.259
G1 F2700 X84.259 Y70.322 E189.49683
G0 F4200 X84.259 Y72.948
G1 F2700 X77.051 Y65.740 E189.83249
G0 F4200 X73.761 Y65.739
G1 F2700 X65.740 Y73.760 E190.20600
G1 F2400 E189.20600
G0 F4200 X65.739 Y69.510
G1 F2400 E190.20600
G1 F2700 X80.489 Y84.259 E190.89283
G1 F2400 E189.89283
G0 F4200 X84.259 Y80.489
G1 F2400 E190.89283
G1 F2700 X69.510 Y65.740 E191.57964
G0 F4200 X66.220 Y65.739
G1 F2700 X65.740 Y66.219 E191.60199
G1 F2400 E190.60199
G0 F4200 X77.863 Y84.259
G1 F2400 E191.60199
G1 F2700 X84.259 Y77.863 E191.89983
;LAYER:10
G1 F2400 E190.89983
G0 F4200 X84.400 Y84.400 Z2.280
;TYPE:WALL-INNER
G1 F2400 E191.89983
G1 F2700 X65.600 Y84.400 E192.51887
G1 X65.600 Y65.600 E193.13791
G1 X84.400 Y65.600 E193.75694
G1 X84.400 Y84.400 E194.37598
G0 F4200 X84.800 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y84.800 E195.02136
G1 X65.200 Y65.200 E195.66674
G1 X84.800 Y65.200 E196.31212
G1 X84.800 Y84.800 E196.95750
G1 F2400 E195.95750
G0 F4200 X80.489 Y84.259
;TYPE:FILL
G1 F2400 E196.95750
G1 F2700 X65.739 Y69.510 E197.64433
G0 F4200 X65.740 Y66.219
G1 F2700 X66.220 Y65.739 E197.66669
G0 F4200 X69.510 Y65.740
G1 F2700 X84.259 Y80.489 E198.35350
G0 F4200 X84.259 Y77.863
G1 F2700 X77.863 Y84.259 E198.65134
G1 F2400 E197.65134
G0 F4200 X72.948 Y84.259
G1 F2400 E198.65134
G1 F2700 X65.739 Y77.050 E198.98703
G0 F4200 X65.740 Y73.760
G1 F2700 X73.761 Y65.739 E199.36055
G0 F4200 X77.051 Y65.740
G1 F2700 X84.259 Y72.948 E199.69620
G0 F4200 X84.259 Y70.322
G1 F2700 X70.322 Y84.259 E200.34520
G1 F2400 E199.34520
G0 F4200 X65.740 Y81.301
G1 F2400 E200.34520
G1 F2700 X81.301 Y65.739 E201.06984
;LAYER:11
G0 F4200 X84.400 Y65.600 Z2.478
;TYPE:WALL-INNER
G1 F2700 X84.400 Y84.400 E201.68888
G1 X65.600 Y84.400 E202.30792
G1 X65.600 Y65.600 E202.92695
G1 X84.400 Y65.600 E203.54599
G0 F4200 X84.800 Y65.200
;TYPE:WALL-OUTER
G1 F2700 X84.800 Y84.800 E204.19137
G1 X65.200 Y84.800 E204.83675
G1 X65.200 Y65.200 E205.48213
G1 X84.800 Y65.200 E206.12751
G0 F4200 X81.301 Y65.739
;TYPE:FILL
G1 F2700 X65.740 Y81.301 E206.85216
G1 F2400 E205.85216
G0 F4200 X65.739 Y77.050
G1 F2400 E206.85216
G1 F2700 X72.948 Y84.259 E207.18785
G0 F4200 X70.322 Y84.259
G1 F2700 X84.259 Y70.322 E207.83685
G0 F4200 X84.259 Y72.948
G1 F2700 X77.051 Y65.740 E208.17250
G0 F4200 X73.761 Y65.739
G1 F2700 X65.740 Y73.760 E208.54601
G1 F2400 E207.54601
G0 F4200 X65.739 Y69.510
G1 F2400 E208.54601
G1 F2700 X80.489 Y84.259 E209.23285
G1 F2400 E208.23285
G0 F4200 X84.259 Y80.489
G1 F2400 E209.23285
G1 F2700 X69.510 Y65.740 E209.91966
G0 F4200 X66.220 Y65.739
G1 F2700 X65.740 Y66.219 E209.94201
G1 F2400 E208.94201
G0 F4200 X77.863 Y84.259
G1 F2400 E209.94201
G1 F2700 X84.259 Y77.863 E210.23985
;LAYER:12
G1 F2400 E209.23985
G0 F4200 X84.400 Y84.400 Z2.676
;TYPE:WALL-INNER
G1 F2400 E210.23985
G1 F2700 X65.600 Y84.400 E210.85889
G1 X65.600 Y65.600 E211.47793
G1 X84.400 Y65.600 E212.09696
G1 X84.400 Y84.400 E212.71600
G0 F4200 X84.800 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y84.800 E213.36138
G1 X65.200 Y65.200 E214.00676
G1 X84.800 Y65.200 E214.65214
G1 X84.800 Y84.800 E215.29752
G0 F4200 X83.976 Y84.259
;TYPE:SKIN
G1 F2700 X65.739 Y66.022 E216.14675
G0 F4200 X66.023 Y65.740
G1 F2700 X84.259 Y83.976 E216.99594
G0 F4200 X84.259 Y83.411
G1 F2700 X66.588 Y65.740 E217.81882
G0 F4200 X67.154 Y65.740
G1 F2700 X84.259 Y82.845 E218.61534
G0 F4200 X84.259 Y82.279
G1 F2700 X67.720 Y65.740 E219.38550
G0 F4200 X68.286 Y65.740
G1 F2700 X84.259 Y81.713 E220.12931
G0 F4200 X84.259 Y81.148
G1 F2700 X68.851 Y65.740 E220.84681
G0 F4200 X69.417 Y65.740
G1 F2700 X84.259 Y80.582 E221.53795
G0 F4200 X84.259 Y80.016
G1 F2700 X69.983 Y65.740 E222.20274
G0 F4200 X70.548 Y65.740
G1 F2700 X84.259 Y79.451 E222.84121
G0 F4200 X84.259 Y78.885
G1 F2700 X71.114 Y65.740 E223.45333
G0 F4200 X71.680 Y65.740
G1 F2700 X84.259 Y78.319 E224.03909
G0 F4200 X84.259 Y77.754
G1 F2700 X72.245 Y65.740 E224.59854
G0 F4200 X72.811 Y65.740
G1 F2700 X84.259 Y77.188 E225.13163
G0 F4200 X84.259 Y76.622
G1 F2700 X73.377 Y65.740 E225.63837
G0 F4200 X73.942 Y65.740
G1 F2700 X84.259 Y76.057 E226.11880
G0 F4200 X84.259 Y75.491
G1 F2700 X74.508 Y65.740 E226.57287
G0 F4200 X75.074 Y65.740
G1 F2700 X84.259 Y74.925 E227.00058
G0 F4200 X84.259 Y74.360
G1 F2700 X75.639 Y65.740 E227.40199
G0 F4200 X76.205 Y65.740
G1 F2700 X84.259 Y73.794 E227.77703
G0 F4200 X84.259 Y73.228
G1 F2700 X76.771 Y65.740 E228.12572
G0 F4200 X77.336 Y65.740
G1 F2700 X84.259 Y72.662 E228.44808
G0 F4200 X84.259 Y72.097
G1 F2700 X77.902 Y65.740 E228.74410
G0 F4200 X78.468 Y65.740
G1 F2700 X84.259 Y71.531 E229.01377
G0 F4200 X84.259 Y70.965
G1 F2700 X79.034 Y65.740 E229.25708
G0 F4200 X79.599 Y65.740
G1 F2700 X84.259 Y70.400 E229.47408
G0 F4200 X84.259 Y69.834
G1 F2700 X80.165 Y65.740 E229.66472
G0 F4200 X80.731 Y65.740
G1 F2700 X84.259 Y69.268 E229.82901
G0 F4200 X84.259 Y68.703
G1 F2700 X81.296 Y65.740 E229.96699
G0 F4200 X81.862 Y65.740
G1 F2700 X84.259 Y68.137 E230.07861
G0 F4200 X84.259 Y67.571
G1 F2700 X82.428 Y65.740 E230.16387
G0 F4200 X82.993 Y65.740
G1 F2700 X84.259 Y67.006 E230.22282
G0 F4200 X84.259 Y66.440
G1 F2700 X83.559 Y65.740 E230.25542
G0 F4200 X84.125 Y65.740
G1 F2700 X84.259 Y65.874 E230.26166
G1 F2400 E229.26166
G0 F4200 X83.411 Y84.259
G1 F2400 E230.26166
G1 F2700 X65.739 Y66.588 E231.08456
G0 F4200 X65.739 Y67.153
G1 F2700 X82.845 Y84.259 E231.88113
G0 F4200 X82.279 Y84.259
G1 F2700 X65.739 Y67.719 E232.65134
G0 F4200 X65.739 Y68.285
G1 F2700 X81.713 Y84.259 E233.39520
G0 F4200 X81.148 Y84.259
G1 F2700 X65.739 Y68.850 E234.11274
G0 F4200 X65.739 Y69.416
G1 F2700 X80.582 Y84.259 E234.80393
G0 F4200 X80.016 Y84.259
G1 F2700 X65.739 Y69.982 E235.46876
G0 F4200 X65.739 Y70.548
G1 F2700 X79.451 Y84.259 E236.10726
G0 F4200 X78.885 Y84.259
G1 F2700 X65.739 Y71.113 E236.71942
G0 F4200 X65.739 Y71.679
G1 F2700 X78.319 Y84.259 E237.30523
G0 F4200 X77.754 Y84.259
G1 F2700 X65.739 Y72.245 E237.86470
G0 F4200 X65.739 Y72.810
G1 F2700 X77.188 Y84.259 E238.39784
G0 F4200 X76.622 Y84.259
G1 F2700 X65.739 Y73.376 E238.90463
G0 F4200 X65.739 Y73.942
G1 F2700 X76.057 Y84.259 E239.38508
G0 F4200 X75.491 Y84.259
G1 F2700 X65.739 Y74.507 E239.83919
G0 F4200 X65.739 Y75.073
G1 F2700 X74.925 Y84.259 E240.26695
G0 F4200 X74.360 Y84.259
G1 F2700 X65.739 Y75.639 E240.66838
G0 F4200 X65.739 Y76.204
G1 F2700 X73.794 Y84.259 E241.04347
G0 F4200 X73.228 Y84.259
G1 F2700 X65.739 Y76.770 E241.39221
G0 F4200 X65.739 Y77.336
G1 F2700 X72.662 Y84.259 E241.71459
G0 F4200 X72.097 Y84.259
G1 F2700 X65.739 Y77.901 E242.01066
G0 F4200 X65.739 Y78.467
G1 F2700 X71.531 Y84.259 E242.28038
G0 F4200 X70.965 Y84.259
G1 F2700 X65.739 Y79.033 E242.52373
G0 F4200 X65.739 Y79.599
G1 F2700 X70.400 Y84.259 E242.74076
G0 F4200 X69.834 Y84.259
G1 F2700 X65.739 Y80.164 E242.93145
G0 F4200 X65.739 Y80.730
G1 F2700 X69.268 Y84.259 E243.09578
G0 F4200 X68.703 Y84.259
G1 F2700 X65.739 Y81.296 E243.23378
G0 F4200 X65.739 Y81.861
G1 F2700 X68.137 Y84.259 E243.34545
G0 F4200 X67.571 Y84.259
G1 F2700 X65.739 Y82.427 E243.43076
G0 F4200 X65.739 Y82.993
G1 F2700 X67.006 Y84.259 E243.48973
G0 F4200 X66.440 Y84.259
G1 F2700 X65.739 Y83.558 E243.52238
G0 F4200 X65.739 Y84.124
G1 F2700 X65.874 Y84.259 E243.52866
;LAYER:13
G0 F4200 X65.600 Y84.400 Z2.874
;TYPE:WALL-INNER
G1 F2700 X65.600 Y65.600 E244.14770
G1 X84.400 Y65.600 E244.76674
G1 X84.400 Y84.400 E245.38577
G1 X65.600 Y84.400 E246.00481
G0 F4200 X65.200 Y84.800
;TYPE:WALL-OUTER
G1 F2700 X65.200 Y65.200 E246.65019
G1 X84.800 Y65.200 E247.29557
G1 X84.800 Y84.800 E247.94095
G1 X65.200 Y84.800 E248.58633
G0 F4200 X65.929 Y84.259
;TYPE:SKIN
G1 F2700 X84.259 Y65.929 E249.43990
G0 F4200 X83.884 Y65.739
G1 F2700 X65.740 Y83.883 E250.28480
G0 F4200 X65.740 Y83.317
G1 F2700 X83.318 Y65.739 E251.10335
G0 F4200 X82.752 Y65.739
G1 F2700 X65.740 Y82.751 E251.89554
G0 F4200 X65.740 Y82.186
G1 F2700 X82.187 Y65.739 E252.66142
G0 F4200 X81.621 Y65.739
G1 F2700 X65.740 Y81.620 E253.40094
G0 F4200 X65.740 Y81.054
G1 F2700 X81.055 Y65.739 E254.11411
G0 F4200 X80.489 Y65.739
G1 F2700 X65.740 Y80.489 E254.80094
G0 F4200 X66.495 Y84.259
G1 F2700 X84.259 Y66.495 E255.62815
G0 F4200 X84.259 Y67.061
G1 F2700 X67.061 Y84.259 E256.42900
G0 F4200 X67.626 Y84.259
G1 F2700 X84.259 Y67.626 E257.20354
G0 F4200 X84.259 Y68.192
G1 F2700 X68.192 Y84.259 E257.95173
G0 F4200 X68.758 Y84.259
G1 F2700 X84.259 Y68.758 E258.67356
G0 F4200 X84.259 Y69.324
G1 F2700 X69.324 Y84.259 E259.36903
G0 F4200 X69.889 Y84.259
G1 F2700 X84.259 Y69.889 E260.03819
G0 F4200 X84.259 Y70.455
G1 F2700 X70.455 Y84.259 E260.68100
G0 F4200 X71.021 Y84.259
G1 F2700 X84.259 Y71.021 E261.29744
G0 F4200 X84.259 Y71.586
G1 F2700 X71.586 Y84.259 E261.88758
G0 F4200 X72.152 Y84.259
G1 F2700 X84.259 Y72.152 E262.45136
G0 F4200 X84.259 Y72.718
G1 F2700 X72.718 Y84.259 E262.98879
G0 F4200 X73.283 Y84.259
G1 F2700 X84.259 Y73.283 E263.49990
G0 F4200 X84.259 Y73.849
G1 F2700 X73.849 Y84.259 E263.98466
G0 F4200 X74.415 Y84.259
G1 F2700 X84.259 Y74.415 E264.44306
G0 F4200 X84.259 Y74.980
G1 F2700 X74.980 Y84.259 E264.87515
G0 F4200 X75.546 Y84.259
G1 F2700 X84.259 Y75.546 E265.28089
G0 F4200 X84.259 Y76.112
G1 F2700 X76.112 Y84.259 E265.66026
G0 F4200 X76.677 Y84.259
G1 F2700 X84.259 Y76.677 E266.01333
G0 F4200 X84.259 Y77.243
G1 F2700 X77.243 Y84.259 E266.34004
G0 F4200 X77.809 Y84.259
G1 F2700 X84.259 Y77.809 E266.64040
G0 F4200 X84.259 Y78.375
G1 F2700 X78.375 Y84.259 E266.91440
G0 F4200 X78.940 Y84.259
G1 F2700 X84.259 Y78.940 E267.16208
G0 F4200 X84.259 Y79.506
G1 F2700 X79.506 Y84.259 E267.38341
G0 F4200 X80.072 Y84.259
G1 F2700 X84.259 Y80.072 E267.57839
G0 F4200 X84.259 Y80.637
G1 F2700 X80.637 Y84.259 E267.74705
G0 F4200 X81.203 Y84.259
G1 F2700 X84.259 Y81.203 E267.88936
G0 F4200 X84.259 Y81.769
G1 F2700 X81.769 Y84.259 E268.00531
G0 F4200 X82.334 Y84.259
G1 F2700 X84.259 Y82.334 E268.09495
G0 F4200 X84.259 Y82.900
G1 F2700 X82.900 Y84.259 E268.15824
G0 F4200 X83.466 Y84.259
G1 F2700 X84.259 Y83.466 E268.19516
G0 F4200 X84.259 Y84.031
G1 F2700 X84.031 Y84.259 E268.20578
G1 F2400 E267.20578
G0 F4200 X65.740 Y79.923
G1 F2400 E268.20578
G1 F2700 X79.924 Y65.739 E268.86628
G0 F4200 X79.358 Y65.739
G1 F2700 X65.740 Y79.357 E269.50042
G0 F4200 X65.740 Y78.792
G1 F2700 X78.792 Y65.739 E270.10823
G0 F4200 X78.227 Y65.739
G1 F2700 X65.740 Y78.226 E270.68971
G0 F4200 X65.740 Y77.660
G1 F2700 X77.661 Y65.739 E271.24483
G0 F4200 X77.095 Y65.739
G1 F2700 X65.740 Y77.095 E271.77362
G0 F4200 X65.740 Y76.529
G1 F2700 X76.530 Y65.739 E272.27607
G0 F4200 X75.964 Y65.739
G1 F2700 X65.740 Y75.963 E272.75217
G0 F4200 X65.740 Y75.398
G1 F2700 X75.398 Y65.739 E273.20193
G0 F4200 X74.833 Y65.739
G1 F2700 X65.740 Y74.832 E273.62536
G0 F4200 X65.740 Y74.266
G1 F2700 X74.267 Y65.739 E274.02243
G0 F4200 X73.701 Y65.739
G1 F2700 X65.740 Y73.701 E274.39317
G0 F4200 X65.740 Y73.135
G1 F2700 X73.136 Y65.739 E274.73758
G0 F4200 X72.570 Y65.739
G1 F2700 X65.740 Y72.569 E275.05563
G0 F4200 X65.740 Y72.003
G1 F2700 X72.004 Y65.739 E275.34732
G0 F4200 X71.438 Y65.739
G1 F2700 X65.740 Y71.438 E275.61268
G0 F4200 X65.740 Y70.872
G1 F2700 X70.873 Y65.739 E275.85171
G0 F4200 X70.307 Y65.739
G1 F2700 X65.740 Y70.306 E276.06438
G0 F4200 X65.740 Y69.741
G1 F2700 X69.741 Y65.739 E276.25071
G0 F4200 X69.176 Y65.739
G1 F2700 X65.740 Y69.175 E276.41072
G0 F4200 X65.740 Y68.609
G1 F2700 X68.610 Y65.739 E276.54436
G0 F4200 X68.044 Y65.739
G1 F2700 X65.740 Y68.044 E276.65167
G0 F4200 X65.740 Y67.478
G1 F2700 X67.479 Y65.739 E276.73265
G0 F4200 X66.913 Y65.739
G1 F2700 X65.740 Y66.912 E276.78728
G0 F4200 X65.740 Y66.347
G1 F2700 X66.347 Y65.739 E276.81556
;LAYER:14
G0 F4200 X65.600 Y65.600 Z3.072
;TYPE:WALL-INNER
G1 F2700 X84.400 Y65.600 E277.43460
G1 X84.400 Y84.400 E278.05364
G1 X65.600 Y84.400 E278.67268
G1 X65.600 Y65.600 E279.29172
G0 F4200 X65.200 Y65.200
;TYPE:WALL-OUTER
G1 F2700 X84.800 Y65.200 E279.93709
G1 X84.800 Y84.800 E280.58247
G1 X65.200 Y84.800 E281.22785
G1 X65.200 Y65.200 E281.87323
G0 F4200 X65.739 Y66.022
;TYPE:SKIN
G1 F2700 X83.976 Y84.259 E282.72247
G0 F4200 X84.259 Y83.976
G1 F2700 X66.023 Y65.740 E283.57166
G0 F4200 X66.588 Y65.740
G1 F2700 X84.259 Y83.411 E284.39453
G0 F4200 X84.259 Y82.845
G1 F2700 X67.154 Y65.740 E285.19106
G0 F4200 X67.720 Y65.740
G1 F2700 X84.259 Y82.279 E285.96122
G0 F4200 X84.259 Y81.713
G1 F2700 X68.286 Y65.740 E286.70503
G0 F4200 X68.851 Y65.740
G1 F2700 X84.259 Y81.148 E287.42252
G0 F4200 X84.259 Y80.582
G1 F2700 X69.417 Y65.740 E288.11367
G0 F4200 X69.983 Y65.740
G1 F2700 X84.259 Y80.016 E288.77845
G1 F2400 E287.77845
G0 F4200 X83.411 Y84.259
G1 F2400 E288.77845
G1 F2700 X65.739 Y66.588 E289.60135
G0 F4200 X65.739 Y67.153
G1 F2700 X82.845 Y84.259 E290.39792
G0 F4200 X82.279 Y84.259
G1 F2700 X65.739 Y67.719 E291.16813
G0 F4200 X65.739 Y68.285
G1 F2700 X81.713 Y84.259 E291.91198
G0 F4200 X81.148 Y84.259
G1 F2700 X65.739 Y68.850 E292.62953
G0 F4200 X65.739 Y69.416
G1 F2700 X80.582 Y84.259 E293.32072
G0 F4200 X80.016 Y84.259
G1 F2700 X65.739 Y69.982 E293.98555
G0 F4200 X65.739 Y70.548
G1 F2700 X79.451 Y84.259 E294.62404
G0 F4200 X78.885 Y84.259
G1 F2700 X65.739 Y71.113 E295.23621
G0 F4200 X65.739 Y71.679
G1 F2700 X78.319 Y84.259 E295.82202
G0 F4200 X77.754 Y84.259
G1 F2700 X65.739 Y72.245 E296.38149
G0 F4200 X65.739 Y72.810
G1 F2700 X77.188 Y84.259 E296.91463
G0 F4200 X76.622 Y84.259
G1 F2700 X65.739 Y73.376 E297.42141
G0 F4200 X65.739 Y73.942
G1 F2700 X76.057 Y84.259 E297.90186
G0 F4200 X75.491 Y84.259
G1 F2700 X65.739 Y74.507 E298.35598
G0 F4200 X65.739 Y75.073
G1 F2700 X74.925 Y84.259 E298.78374
G0 F4200 X74.360 Y84.259
G1 F2700 X65.739 Y75.639 E299.18517
G0 F4200 X65.739 Y76.204
G1 F2700 X73.794 Y84.259 E299.56026
G0 F4200 X73.228 Y84.259
G1 F2700 X65.739 Y76.770 E299.90900
G0 F4200 X65.739 Y77.336
G1 F2700 X72.662 Y84.259 E300.23138
G0 F4200 X72.097 Y84.259
G1 F2700 X65.739 Y77.901 E300.52745
G0 F4200 X65.739 Y78.467
G1 F2700 X71.531 Y84.259 E300.79716
G0 F4200 X70.965 Y84.259
G1 F2700 X65.739 Y79.033 E301.04052
G0 F4200 X65.739 Y79.599
G1 F2700 X70.400 Y84.259 E301.25754
G0 F4200 X69.834 Y84.259
G1 F2700 X65.739 Y80.164 E301.44823
G0 F4200 X65.739 Y80.730
G1 F2700 X69.268 Y84.259 E301.61257
G0 F4200 X68.703 Y84.259
G1 F2700 X65.739 Y81.296 E301.75057
G0 F4200 X65.739 Y81.861
G1 F2700 X68.137 Y84.259 E301.86223
G0 F4200 X67.571 Y84.259
G1 F2700 X65.739 Y82.427 E301.94754
G0 F4200 X65.739 Y82.993
G1 F2700 X67.006 Y84.259 E302.00652
G0 F4200 X66.440 Y84.259
G1 F2700 X65.739 Y83.558 E302.03916
G0 F4200 X65.739 Y84.124
G1 F2700 X65.874 Y84.259 E302.04545
G1 F2400 E301.04545
G0 F4200 X84.259 Y79.451
G1 F2400 E302.04545
G1 F2700 X70.548 Y65.740 E302.68392
G0 F4200 X71.114 Y65.740
G1 F2700 X84.259 Y78.885 E303.29604
G0 F4200 X84.259 Y78.319
G1 F2700 X71.680 Y65.740 E303.88180
G0 F4200 X72.245 Y65.740
G1 F2700 X84.259 Y77.754 E304.44125
G0 F4200 X84.259 Y77.188
G1 F2700 X72.811 Y65.740 E304.97435
G0 F4200 X73.377 Y65.740
G1 F2700 X84.259 Y76.622 E305.48109
G0 F4200 X84.259 Y76.057
G1 F2700 X73.942 Y65.740 E305.96151
G0 F4200 X74.508 Y65.740
G1 F2700 X84.259 Y75.491 E306.41558
G0 F4200 X84.259 Y74.925
G1 F2700 X75.074 Y65.740 E306.84330
G0 F4200 X75.639 Y65.740
G1 F2700 X84.259 Y74.360 E307.24470
G0 F4200 X84.259 Y73.794
G1 F2700 X76.205 Y65.740 E307.61975
G0 F4200 X76.771 Y65.740
G1 F2700 X84.259 Y73.228 E307.96844
G0 F4200 X84.259 Y72.662
G1 F2700 X77.336 Y65.740 E308.29080
G0 F4200 X77.902 Y65.740
G1 F2700 X84.259 Y72.097 E308.58682
G0 F4200 X84.259 Y71.531
G1 F2700 X78.468 Y65.740 E308.85649
G0 F4200 X79.034 Y65.740
G1 F2700 X84.259 Y70.965 E309.09980
G0 F4200 X84.259 Y70.400
G1 F2700 X79.599 Y65.740 E309.31680
G0 F4200 X80.165 Y65.740
G1 F2700 X84.259 Y69.834 E309.50744
G0 F4200 X84.259 Y69.268
G1 F2700 X80.731 Y65.740 E309.67173
G0 F4200 X81.296 Y65.740
G1 F2700 X84.259 Y68.703 E309.80970
G0 F4200 X84.259 Y68.137
G1 F2700 X81.862 Y65.740 E309.92132
G0 F4200 X82.428 Y65.740
G1 F2700 X84.259 Y67.571 E310.00659
G0 F4200 X84.259 Y67.006
G1 F2700 X82.993 Y65.740 E310.06554
G0 F4200 X83.559 Y65.740
G1 F2700 X84.259 Y66.440 E310.09814
G0 F4200 X84.259 Y65.874
G1 F2700 X84.125 Y65.740 E310.10438
M107
G1 F2400 E309.10438
G0 F4200 X84.125 Y65.740 Z8.000
;End GCode
M104 S0                     ;extruder heater off
M140 S0                     ;heated bed heater off (if you have it)
G91                                    ;relative positioning
G1 E-1 F300                            ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z+0.5 E-5 X-20 Y-20 F4200 ;move Z up a bit and retract filament even more
G28 X0 Y0                              ;move X/Y to min endstops, so the head is out of the way
M84                         ;steppers off
G90                         ;absolute positioning
;CURA_PROFILE_STRING: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

