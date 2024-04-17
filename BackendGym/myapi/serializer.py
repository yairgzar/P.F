from rest_framework import serializers
from .models import tbl_cliente,tbl_rol, tb_membresias, tb_personas, tb_miembros, tb_usuarios, tb_membresias_usuarios

class tbl_clienteSerializer(serializers.ModelSerializer):
	class Meta:
		model = tbl_cliente
		fields = '_all_'
		
class tbl_rolSerializer(serializers.ModelSerializer):
	class Meta:
		model = tbl_rol
		fields = '_all_'

class tb_membresiasSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_membresias
		fields = '_all_'

class tb_personasSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_personas
		fields = '_all_'

class tb_miembrosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_miembros
		fields = '_all_'

class tb_usuariosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_usuarios
		fields = '_all_'

class tb_membresias_usuariosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_membresias_usuarios
		fields = '_all_'