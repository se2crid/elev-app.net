﻿using System.Collections.ObjectModel;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.ComponentModel.__Internals;
using Skolplattformen.ElevApp.Data;
using SkolplattformenElevApi.Models;

namespace Skolplattformen.ElevApp.ViewModels
{
    public partial class TeachersViewModel : ObservableObject
    {
        private readonly SkolplattformenService _skolplattformenService;

        [ObservableProperty] private ObservableCollection<Teacher> items;

        public TeachersViewModel(SkolplattformenService skolplattformenService)
        {
            _skolplattformenService = skolplattformenService;
            items = new ObservableCollection<Teacher>();

            Task.Run(LoadData);
        }

        public async Task LoadData()
        {
            var teachers = await _skolplattformenService.GetTeachersAsync();
            MainThread.BeginInvokeOnMainThread(() =>
            {
                items.Clear();
                foreach (var teacher in teachers.OrderBy(t => t.Lastname))
                {
                    items.Add(teacher);
                }
            });
        }
    }

}
