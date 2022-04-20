package com.kontra.notifications;

import android.util.Log;

import androidx.annotation.NonNull;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.FirebaseFirestore;

import java.util.HashMap;
import java.util.Map;

public class FirebaseOperations {

    static FirebaseFirestore db;
    FirebaseOperations(){
        db = FirebaseFirestore.getInstance();
    }

    public static void putMessage(String title,String data,byte[] image){
        Map<String, Object> notification = new HashMap<>();
        notification.put("title", title);
        notification.put("data", data);
        notification.put("image", image);

// Add a new document with a generated ID
        db.collection("notifications")
                .add(notification)
                .addOnSuccessListener(new OnSuccessListener<DocumentReference>() {
                    @Override
                    public void onSuccess(DocumentReference documentReference) {
                        Log.d("FIREBASE", "DocumentSnapshot added with ID: " + documentReference.getId());
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        Log.w("FIREBASE", "Error adding document", e);
                    }
                });
    }



}
