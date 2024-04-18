from django.urls import path,include
from rest_framework import routers
from myapi import views

router = routers.DefaultRouter()

router.register(r'tb_membresias', views.tb_membresiasViewSet)
router.register(r'tb_personas', views.tb_personasViewSet)
router.register(r'tb_miembros', views.tb_miembrosViewSet)
router.register(r'tb_usuarios', views.tb_usuariosViewSet)
router.register(r'tb_membresias_usuarios', views.tb_membresias_usuariosViewSet)

urlpatterns = [
	path('api/v1',include(router.urls))
]