from rest_framework import viewsets
from .models import tb_membresias, tb_personas, tb_miembros,  tb_usuarios, tb_membresias_usuarios
from .serializer import  tb_membresiasSerializer, tb_personasSerializer, tb_miembrosSerializer, tb_usuariosSerializer, tb_membresias_usuariosSerializer


 
class tb_membresiasViewSet(viewsets.ModelViewSet):
	queryset = tb_membresias.objects.all()
	serializer_class = tb_membresiasSerializer

class tb_personasViewSet(viewsets.ModelViewSet):
	queryset = tb_personas.objects.all()
	serializer_class = tb_personasSerializer

class tb_miembrosViewSet(viewsets.ModelViewSet):
	queryset = tb_miembros.objects.all()
	serializer_class = tb_miembrosSerializer

class tb_usuariosViewSet(viewsets.ModelViewSet):
	queryset = tb_usuarios.objects.all()
	serializer_class = tb_usuariosSerializer

class tb_membresias_usuariosViewSet(viewsets.ModelViewSet):
	queryset = tb_membresias_usuarios.objects.all()
	serializer_class = tb_membresias_usuariosSerializer