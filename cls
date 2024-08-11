[33mcommit 7ca2082657bf6739026f8e3d74612e843b1bafb5[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m)[m
Author: harsh0565 <harshsengar099@gmail.com>
Date:   Tue Aug 6 12:17:30 2024 +0530

    first

[1mdiff --git a/backend/.env b/backend/.env[m
[1mnew file mode 100644[m
[1mindex 0000000..000f8b7[m
[1m--- /dev/null[m
[1m+++ b/backend/.env[m
[36m@@ -0,0 +1,6 @@[m
[32m+[m[32mPORT = 3000[m[41m [m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32mMONGO_URL = "mongodb://localhost:27017/Summer_Internship"[m
[32m+[m
[1mdiff --git a/backend/.gitignore b/backend/.gitignore[m
[1mnew file mode 100644[m
[1mindex 0000000..b512c09[m
[1m--- /dev/null[m
[1m+++ b/backend/.gitignore[m
[36m@@ -0,0 +1 @@[m
[32m+[m[32mnode_modules[m
\ No newline at end of file[m
[1mdiff --git a/backend/config/db.js b/backend/config/db.js[m
[1mnew file mode 100644[m
[1mindex 0000000..fb27d4a[m
[1m--- /dev/null[m
[1m+++ b/backend/config/db.js[m
[36m@@ -0,0 +1,17 @@[m
[32m+[m[32mimport mongoose from "mongoose";[m
[32m+[m[32mconst connectDB = async()=>{[m
[32m+[m[32m    try{[m
[32m+[m[41m        [m
[32m+[m[32m        await mongoose.connect(process.env.MONGO_URL).then(()=>{[m
[32m+[m[32m            console.log(`connected to the database successfully`);[m
[32m+[m[32m        }).catch((err)=>{[m
[32m+[m[32m            console.log("error in connection database" ,err);[m
[32m+[m[32m        })[m
[32m+[m
[32m+[m[32m    }[m
[32m+[m[32m    catch(error){[m
[32m+[m[32m        console.log(error);[m
[32m+[m[32m    }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport default connectDB;[m
\ No newline at end of file[m
[1mdiff --git a/backend/controller/authController.js b/backend/controller/authController.js[m
[1mnew file mode 100644[m
[1mindex 0000000..d5bb0a5[m
[1m--- /dev/null[m
[1m+++ b/backend/controller/authController.js[m
[36m@@ -0,0 +1,340 @@[m
[32m+[m[32mimport { comparePassword, hashPassword } from "../helper/authHelper.js";[m
[32m+[m[32mimport UserModel from "../models/userModel.js";[m
[32m+[m[32mimport jwt from "jsonwebtoken";[m
[32m+[m[32mimport MovieModel from './../models/movieModel.js';[m
[32m+[m[32mimport FavouriteModel from './../models/FavouriteModel.js';[m
[32m+[m
[32m+[m[32mexport const Home = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    res.send("home page");[m
[32m+[m[32m  } catch (err) {[m
[32m+[m[32m    console.log(err);[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport const Profile = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const token = req.body.token;[m
[32m+[m[32m    if (!token) {[m
[32m+[m[32m      return res.status(400).send("Please provide a token.");[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    let decoded;[m
[32m+[m[32m    try {[m
[32m+[m[32m      decoded = jwt.verify(token, "asdfksahfsakjdfj");[m
[32m+[m[32m    } catch (err) {[m
[32m+[m[32m      if (err.name === "TokenExpiredError") {[m
[32m+[m[32m        return res.status(401).send("Token has expired, please log in again.");[m
[32m+[m[32m      } else if (err.name === "JsonWebTokenError") {[m
[32m+[m[32m        return res.status(401).send("Invalid token, please log in again.");[m
[32m+[m[32m      } else {[m
[32m+[m[32m        return res[m
[32m+[m[32m          .status(500)[m
[32m+[m[32m          .send("An error occurred while verifying the token.");[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    if (!decoded) {[m
[32m+[m[32m      return res.status(401).send("Ivalid token, please log in again.");[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    console.log(decoded._id);[m
[32m+[m[32m    const activeUser = await UserModel.findById(decoded._id);[m
[32m+[m[32m    if (!activeUser) {[m
[32m+[m[32m      return res.status(404).send("User not found.");[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    const { name, email } = activeUser;[m
[32m+[m
[32m+[m[32m    res.send({[m
[32m+[m[32m      msg: "You are an active user",[m
[32m+[m[32m      name,[m
[32m+[m[32m      email,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (err) {[m
[32m+[m[32m    console.error(err);[m
[32m+[m[32m    res.status(500).send("An error occurred.");[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m[32mexport const Unauthorize = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    await res.status(401).send("Unauthorized URL access");[m
[32m+[m[32m  } catch (err) {[m
[32m+[m[32m    console.log(err);[m
[32m+[m[32m    res.status(500).send("Internal Server Error");[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport const registerController = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const { name, email, phone, password } = req.body;[m
[32m+[m[32m    if (!name) {[m
[32m+[m[32m      return res.send({ error: "Name is required" });[m
[32m+[m[32m    }[m
[32m+[m[32m    if (!email) {[m
[32m+[m[32m      return res.send({ error: "Email is required" });[m
[32m+[m[32m    }[m
[32m+[m[32m    if (!password) {[m
[32m+[m[32m      return res.send({ error: "Password is required" });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    const existingUser = await UserModel.findOne({ email });[m
[32m+[m[32m    if (existingUser) {[m
[32m+[m[32m      return res.status(200).send({[m
[32m+[m[32m        success: true,[m
[32m+[m[32m        message: "Already registered, please login",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    const hashedPassword = await hashPassword(password);[m
[32m+[m[32m    const user = await new UserModel({[m
[32m+[m[32m      name,[m
[32m+[m[32m      email,[m
[32m+[m[32m      phone,[m
[32m+[m[32m      password: hashedPassword,[m
[32m+[m[32m    }).save();[m
[32m+[m
[32m+[m[32m    res.send({[m
[32m+[m[32m      success: true,[m
[32m+[m[32m      message: "User registered successfully",[m
[32m+[m[32m      user,[m
[32m+[m[32m    });[m
[32m+[m[32m  } catch (error) {[m
[32m+[m[32m    console.log(error);[m
[32m+[m[32m    res.status(500).send({[m
[32m+[m[32m      success: false,[m
[32m+[m[32m      message: "Error in registration",[m
[32m+[m[32m      error,[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m[32m};[m
[32m+[m
[32m+[m[32mexport const loginController = async (req, res) => {[m
[32m+[m[32m  try {[m
[32m+[m[32m    const { email, password } = req.body;[m
[32m+[m
[32m+[m[32m    // Check if email or password is missing[m
[32m+[m[32m    if (!email || !password) {[m
[32m+[m[32m      return res.status(400).send({[m
[32m+[m[32m        success: false,[m
[32m+[m[32m        message: "Invalid email or password",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Find the user[m
[32m+[m[32m    const user = await UserModel.findOne({ email });[m
[32m+[m
[32m+[m[32m    // Check if user exists[m
[32m+[m[32m    if (!user) {[m
[32m+[m[32m      return res.status(404).send({[m
[32m+[m[32m        success: false,[m
[32m+[m[32m        message: "Email is not registered",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    // Compare passwords[m
[32m+[m[32m    const match = await comparePassword(password, user.password);[m
[32m+[m[32m    if (!match) {[m
[32m+[m[32m      return res.status(400).send({[m
[32m+[m[32m        success: false,[m
[32m+[m[32m        message: "Incorrect password",[m
[32m+[m[32m      });[m
[32m+[m[32m    }[m
[32m+[m
[32m+[m[32m    const JWT_SECRET = "asdfksahfsakjdfj";[m
[32m+[m[32m    // Generate token[m
[32m+[m[32m    const token = jwt.sign({ _id: user._id }, JWT_SECRET, { expiresIn: "60" });[m
[32m+[m
[32m+[m[32m    res.status(200).send({[m
[32m+[m[32m      success: true,[m
[32m+[m[32m      message: "Login successful",[m
[32m+[m[3