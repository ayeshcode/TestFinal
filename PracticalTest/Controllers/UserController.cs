using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PracticalTest.Models;

namespace PracticalTest.Controllers
{
    public class UserController : Controller
    {
        db dbop = new db();
        string msg;
        public IActionResult Index()
        {
            Staff empuser = new Staff();
            empuser.flag = "get";
            DataSet ds = dbop.Empget(empuser, out msg);
            List<Staff> list = new List<Staff>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(new Staff
                {
                    Id = Convert.ToInt32(dr["Id"]),
                    UserName = dr["UserName"].ToString(),
                    Password = dr["Password"].ToString(),
                    Email = dr["Email"].ToString(),
                    Status = dr["Status"].ToString(),
                    Role = dr["Role"].ToString()
                }); 
            }
            return View(list);
        }

        public IActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Create([Bind] Staff empuser)
        {
            try
            {
                empuser.flag = "insert";
                dbop.Empdml(empuser, out msg);
                TempData["msg"] = msg;
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return RedirectToAction("Index");
        }

        public IActionResult Edit(int id)
        {
           Staff empuser = new Staff();
            empuser.Id = id;
            empuser.flag = "getid";
            DataSet ds = dbop.Empget(empuser, out msg);
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                empuser.Id = Convert.ToInt32(dr["Id"]);
                empuser.UserName = dr["UserName"].ToString();
                empuser.Password = dr["Password"].ToString();
                empuser.Email = dr["Email"].ToString();
                empuser.Status = dr["Status"].ToString();
                empuser.Role = dr["Role"].ToString();
            }
            return View(empuser);
        }
        [HttpPost]
        public IActionResult Edit(int id, [Bind] Staff empuser)
        {
            try
            {
                empuser.Id = id;
                empuser.flag = "update";
                dbop.Empdml(empuser, out msg);
                TempData["msg"] = msg;
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return RedirectToAction("Index");
        }

        public IActionResult Delete(int id)
        {
            try
            {
                Staff empuser = new Staff();
                empuser.flag = "delete";
                empuser.Id = id;
                dbop.Empdml(empuser, out msg);
                TempData["msg"] = msg;
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return RedirectToAction("Index");
        }
    }
}