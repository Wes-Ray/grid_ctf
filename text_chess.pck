GDPC                                                                            
   <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex I      �       �+�k1��y-�ߙ��l�   res://checker_board.gd.remap`L      (       X�
���u�ԙ��i�   res://checker_board.gdc              }���	��B_����d   res://checker_board.tscn      8      e"W���A�Y�~P�(   res://checker_cell/checker_cell.gd.remap�L      4       �-H���#��x�o:�$   res://checker_cell/checker_cell.gdc  F      �      �D�|S���rFyJ$   res://checker_cell/checker_cell.tscnH            �m@��; �[L;���G   res://icon.png  �L      �      �t��E�e%(����A�   res://icon.png.import   �I      �      ��fe��6�B��^ U�   res://project.binary�N      m      �f����&�E��0            GDSC   *      d   
     �������������Ķ�   ���Ҷ���   ������������Ķ��   ������������Ķ��   ���϶���   ������������Ķ��   ���϶���   ���Ӷ���   ���Ӷ���   �����϶�   �嶶   ��������������Ӷ   ����������Ӷ   ���������������Ҷ���   ���׶���   ���ƶ���   ���ڶ���   �����������ض���   ���¶���   �����Ҷ�   �����������ƶ���   ���Ӷ���   ���Ӷ���   ����   ���ض���   ����󶶶   �����������Ѷ���   ����Ӷ��   ���������������Ҷ���   ���򶶶�   ����������¶   ��ڶ   ��������¶��   ���������������Ҷ���   ��ض   ����¶��   ��������ζ��   ��������Ҷ��   ����������������Ҷ��   ��������Ķ��   ���������������Ķ���   ��������Ҷ��                   user://chess.dat                   /                                  $      %      +      3   	   4   
   :      @      A      F      P      V      Z      a      e      f      o      r      v      w      �      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -     .   	  /   
  0     1     2     3     4     5   #  6   (  7   )  8   3  9   E  :   I  ;   P  <   T  =   X  >   Y  ?   _  @   c  A   j  B   n  C   o  D   u  E   v  F   y  G   }  H   ~  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^   �  _   �  `   �  a   �  b   �  c     d   3YY5;�  W�  �  Y5;�  W�  �  �  Y5;�  W�  �  �  YY0�	  PQV�  �
  T�  �
  T�  �  Y0�  PQV�  ;�  LM�  �  ;�  �  )�  �  T�  PQV�  &�  T�  V�  &�  V�  �  T�  P�  Q�  �  �  �  �  T�  P�  T�  Q�  (V�  �  �  �  �  �  T�  �>  P�  Q�  �  ;�  �  T�  PQ�  �  T�  P�  R�  T�  Q�  �  T�  P�G  P�  QQ�  �  T�  PQ�  Y0�  PQV�  ;�  �  T�  PQ�  �  T�  P�  R�  T�  Q�  ;�  �H  P�  T�  PQQ�  �  T�  PQ�  �  ;�  �  )�  �  T�  PQV�  &�  V�  �  T�  �  �  �  �  �  (V�  ;�  �  T�   PQ�  �  &�  4�  V�  �  �  �  �  �  '�  4�  V�  �  T�  �  �  YY0�!  PQV�  ;�"  �  �  ;�#  �  �  )�  �  T�  PQV�  &�  T�$  PQ�  T�$  PQ�  V�  &�#  V�  �"  �>  P�#  Q�  �#  �  �"  �  �  �  &�  T�  V�  &�#  V�  �"  �>  P�#  Q�  �#  �  �  �"  �  T�  �  �  (V�  �#  �  �  �  &�#  �  V�  �"  �>  P�#  Q�  �#  �  �  �  T�  �"  �  �
  T�%  �"  YY0�&  PQV�  �  )�  �  T�  PQV�  �  T�  �  �  �  ;�"  �
  T�%  �  ;�  �  �  )�'  �"  V�  &�'  �  V�  -�  '�'  T�(  PQV�  �'  �  P�'  Q�  &�'  �  V.�  �  �'  �  (V�  �  T�)  P�  QT�  �'  �  �  �  �  �  &�  �  �  �  V.Y`             [gd_scene load_steps=3 format=2]

[ext_resource path="res://checker_board.gd" type="Script" id=1]
[ext_resource path="res://checker_cell/checker_cell.tscn" type="PackedScene" id=2]

[node name="CheckerBoard" type="PanelContainer"]
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource( 1 )

[node name="VBoxContainer" type="VBoxContainer" parent="."]
margin_left = 7.0
margin_top = 7.0
margin_right = 305.0
margin_bottom = 337.0

[node name="HBoxContainer" type="HBoxContainer" parent="VBoxContainer"]
margin_right = 298.0
margin_bottom = 20.0

[node name="Save" type="Button" parent="VBoxContainer/HBoxContainer"]
margin_right = 41.0
margin_bottom = 20.0
text = "Save"

[node name="Load" type="Button" parent="VBoxContainer/HBoxContainer"]
margin_left = 45.0
margin_right = 87.0
margin_bottom = 20.0
text = "Load"

[node name="VSeparator" type="VSeparator" parent="VBoxContainer/HBoxContainer"]
margin_left = 91.0
margin_right = 95.0
margin_bottom = 20.0

[node name="Copy" type="Button" parent="VBoxContainer/HBoxContainer"]
margin_left = 99.0
margin_right = 142.0
margin_bottom = 20.0
text = "Copy"

[node name="Paste" type="Button" parent="VBoxContainer/HBoxContainer"]
margin_left = 146.0
margin_right = 193.0
margin_bottom = 20.0
text = "Paste"

[node name="Label" type="Label" parent="VBoxContainer/HBoxContainer"]
margin_left = 197.0
margin_top = 3.0
margin_right = 221.0
margin_bottom = 17.0
text = "FEN"

[node name="HSeparator" type="HSeparator" parent="VBoxContainer"]
margin_top = 24.0
margin_right = 298.0
margin_bottom = 28.0

[node name="PanelContainer" type="PanelContainer" parent="VBoxContainer"]
margin_top = 32.0
margin_right = 298.0
margin_bottom = 330.0

[node name="GridContainer" type="GridContainer" parent="VBoxContainer/PanelContainer"]
margin_left = 7.0
margin_top = 7.0
margin_right = 291.0
margin_bottom = 291.0
columns = 8

[node name="CheckerCell" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_right = 32.0
margin_bottom = 32.0
text = "r"

[node name="CheckerCell2" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_right = 68.0
margin_bottom = 32.0
text = "n"

[node name="CheckerCell3" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_right = 104.0
margin_bottom = 32.0
text = "b"

[node name="CheckerCell4" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_right = 140.0
margin_bottom = 32.0
text = "q"

[node name="CheckerCell5" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_right = 176.0
margin_bottom = 32.0
text = "k"

[node name="CheckerCell6" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_right = 212.0
margin_bottom = 32.0
text = "b"

[node name="CheckerCell7" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_right = 248.0
margin_bottom = 32.0
text = "n"

[node name="CheckerCell8" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_right = 284.0
margin_bottom = 32.0
text = "r"

[node name="CheckerCell9" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 36.0
margin_right = 32.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell10" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 36.0
margin_right = 68.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell11" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 36.0
margin_right = 104.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell12" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 36.0
margin_right = 140.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell13" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 36.0
margin_right = 176.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell14" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 36.0
margin_right = 212.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell15" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 36.0
margin_right = 248.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell16" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 36.0
margin_right = 284.0
margin_bottom = 68.0
text = "p"

[node name="CheckerCell17" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 72.0
margin_right = 32.0
margin_bottom = 104.0

[node name="CheckerCell18" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 72.0
margin_right = 68.0
margin_bottom = 104.0

[node name="CheckerCell19" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 72.0
margin_right = 104.0
margin_bottom = 104.0

[node name="CheckerCell20" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 72.0
margin_right = 140.0
margin_bottom = 104.0

[node name="CheckerCell21" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 72.0
margin_right = 176.0
margin_bottom = 104.0

[node name="CheckerCell22" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 72.0
margin_right = 212.0
margin_bottom = 104.0

[node name="CheckerCell23" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 72.0
margin_right = 248.0
margin_bottom = 104.0

[node name="CheckerCell24" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 72.0
margin_right = 284.0
margin_bottom = 104.0

[node name="CheckerCell25" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 108.0
margin_right = 32.0
margin_bottom = 140.0

[node name="CheckerCell26" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 108.0
margin_right = 68.0
margin_bottom = 140.0

[node name="CheckerCell27" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 108.0
margin_right = 104.0
margin_bottom = 140.0

[node name="CheckerCell28" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 108.0
margin_right = 140.0
margin_bottom = 140.0

[node name="CheckerCell29" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 108.0
margin_right = 176.0
margin_bottom = 140.0

[node name="CheckerCell30" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 108.0
margin_right = 212.0
margin_bottom = 140.0

[node name="CheckerCell31" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 108.0
margin_right = 248.0
margin_bottom = 140.0

[node name="CheckerCell32" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 108.0
margin_right = 284.0
margin_bottom = 140.0

[node name="CheckerCell33" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 144.0
margin_right = 32.0
margin_bottom = 176.0

[node name="CheckerCell34" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 144.0
margin_right = 68.0
margin_bottom = 176.0

[node name="CheckerCell35" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 144.0
margin_right = 104.0
margin_bottom = 176.0

[node name="CheckerCell36" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 144.0
margin_right = 140.0
margin_bottom = 176.0

[node name="CheckerCell37" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 144.0
margin_right = 176.0
margin_bottom = 176.0

[node name="CheckerCell38" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 144.0
margin_right = 212.0
margin_bottom = 176.0

[node name="CheckerCell39" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 144.0
margin_right = 248.0
margin_bottom = 176.0

[node name="CheckerCell40" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 144.0
margin_right = 284.0
margin_bottom = 176.0

[node name="CheckerCell41" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 180.0
margin_right = 32.0
margin_bottom = 212.0

[node name="CheckerCell42" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 180.0
margin_right = 68.0
margin_bottom = 212.0

[node name="CheckerCell43" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 180.0
margin_right = 104.0
margin_bottom = 212.0

[node name="CheckerCell44" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 180.0
margin_right = 140.0
margin_bottom = 212.0

[node name="CheckerCell45" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 180.0
margin_right = 176.0
margin_bottom = 212.0

[node name="CheckerCell46" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 180.0
margin_right = 212.0
margin_bottom = 212.0

[node name="CheckerCell47" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 180.0
margin_right = 248.0
margin_bottom = 212.0

[node name="CheckerCell48" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 180.0
margin_right = 284.0
margin_bottom = 212.0

[node name="CheckerCell49" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 216.0
margin_right = 32.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell50" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 216.0
margin_right = 68.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell51" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 216.0
margin_right = 104.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell52" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 216.0
margin_right = 140.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell53" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 216.0
margin_right = 176.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell54" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 216.0
margin_right = 212.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell55" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 216.0
margin_right = 248.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell56" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 216.0
margin_right = 284.0
margin_bottom = 248.0
text = "P"

[node name="CheckerCell57" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_top = 252.0
margin_right = 32.0
margin_bottom = 284.0
text = "R"

[node name="CheckerCell58" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 36.0
margin_top = 252.0
margin_right = 68.0
margin_bottom = 284.0
text = "N"

[node name="CheckerCell59" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 72.0
margin_top = 252.0
margin_right = 104.0
margin_bottom = 284.0
text = "B"

[node name="CheckerCell60" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 108.0
margin_top = 252.0
margin_right = 140.0
margin_bottom = 284.0
text = "Q"

[node name="CheckerCell61" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 144.0
margin_top = 252.0
margin_right = 176.0
margin_bottom = 284.0
text = "K"

[node name="CheckerCell62" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 180.0
margin_top = 252.0
margin_right = 212.0
margin_bottom = 284.0
text = "B"

[node name="CheckerCell63" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 216.0
margin_top = 252.0
margin_right = 248.0
margin_bottom = 284.0
text = "N"

[node name="CheckerCell64" parent="VBoxContainer/PanelContainer/GridContainer" instance=ExtResource( 2 )]
margin_left = 252.0
margin_top = 252.0
margin_right = 284.0
margin_bottom = 284.0
text = "R"

[connection signal="pressed" from="VBoxContainer/HBoxContainer/Save" to="." method="_on_Save_pressed"]
[connection signal="pressed" from="VBoxContainer/HBoxContainer/Load" to="." method="_on_Load_pressed"]
[connection signal="pressed" from="VBoxContainer/HBoxContainer/Copy" to="." method="_on_Copy_pressed"]
[connection signal="pressed" from="VBoxContainer/HBoxContainer/Paste" to="." method="_on_Paste_pressed"]
              GDSC            M      �����ض�   �����϶�   �����������ƶ���   ��������ζ��   ������������׶��   ��������ض��   ������������׶��   ���׶���   ���Ӷ���   ��������׶��   ���¶���      text                          	                                 	   '   
   5      6      ?      E      K      3YY0�  PQV�  �  �>  P�  PQQ�  Y0�  P�  QV�  .YY0�  P�  R�  QV�  .�  �  T�  T�  �  Y0�	  P�  R�  QV�  �
  �  T�
  �  �  T�
  �  Y`[gd_scene load_steps=2 format=2]

[ext_resource path="res://checker_cell/checker_cell.gd" type="Script" id=1]

[node name="CheckerCell" type="Button"]
margin_right = 24.0
margin_bottom = 27.0
rect_min_size = Vector2( 32, 32 )
toggle_mode = true
script = ExtResource( 1 )
 GDST@   @            j   WEBPRIFF^   WEBPVP8LR   /?�0��?��pGm$IR�4ɤ9�����	H�	Ziۓ�@�P2�S-�R6(e!�Nt#� l8�́�]rf=�Ho���          [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              [remap]

path="res://checker_board.gdc"
        [remap]

path="res://checker_cell/checker_cell.gdc"
            �PNG

   IHDR   @   @   �iq�  �IDATx^��� C��?���sv���2�ז!�E7�������0��9��Vr�!����/-��@�2	�I6�i��|� h> ��@�I�6L��xU����ӄ͍P (�2, �V)��#�t{���� `"@.O�Q��= 0;?:!b���(�i& J#uy#t��΀nIP禞��/?@A��D �C��j�-Ut�T�{| P!�'O�>Au=u�0�T��P�W�� uCj~ P��H���0��#A�ܺ��u�7p%ӣ�jgH�Ը̀ `�%į�*�)? �(�|�_ 1h;t)�4@d ��� @�jO8I`5ŉ�( ��y:���0���	D�<7:�I.7Aw������m�� �� �7�P���8    IEND�B`�    ECFG      application/config/name      
   text_chess     application/run/main_scene          res://checker_board.tscn   application/config/icon         res://icon.png     display/window/size/width      8     display/window/size/height      X     display/window/size/resizable          )   physics/common/enable_pause_aware_picking            