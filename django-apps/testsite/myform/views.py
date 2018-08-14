from django.shortcuts import render,redirect
from django.views.generic import TemplateView
from django.contrib.auth.models import User

from myform.forms import HomeForm
from myform.models import Post


'''def index(request):
    return render(request, 'myform/index.html', {})'''

class HomeView(TemplateView):
    template_name = 'myform/index.html'

    def get(self, request):
        form = HomeForm()
        return render(request, self.template_name, {'form':form})

    def post(self,request):
        form = HomeForm(request.POST)
        if form.is_valid():
            #text = form.cleaned_data['post']
        #    form = HomeForm()
            return render(request, self.template_name, {'form':form})
