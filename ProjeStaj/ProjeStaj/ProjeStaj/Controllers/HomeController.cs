using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjeStaj.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = " ";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult KayitOl()
        {
            ViewBag.Message = " ";
            return View();
        }


        public ActionResult UrunEkle()
        {
            ViewBag.Message = " ";
            return View();
        }

    }
}