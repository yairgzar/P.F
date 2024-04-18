from rest_framework import serializers
from .models import  tb_membresias, tb_personas, tb_miembros, tb_usuarios, tb_membresias_usuarios


class tb_membresiasSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_membresias
		fields = '__all__'

class tb_personasSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_personas
		fields = '__all__'

class tb_miembrosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_miembros
		fields = '__all__'

class tb_usuariosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_usuarios
		fields = '__all__'

class tb_membresias_usuariosSerializer(serializers.ModelSerializer):
	class Meta:
		model = tb_membresias_usuarios
		fields = '__all__'